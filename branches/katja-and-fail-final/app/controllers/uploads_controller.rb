class UploadsController < InheritedResources::Base
  before_filter :login_required
  
  def create
    @upload = Upload.new(params[:upload])
    @upload.user = current_user
    if @upload.save
      if @upload.uploadtype == 'morphbank'
        redirect_to morphbanks_path
      end
    end
  end

  def morphbank
    @upload = Upload.new
  end

  def morphbank_import
    require 'fastercsv'
    
    # preload species so we can go through this
    @species = Species.find(:all)
    
    @upload = Upload.find(params[:id])
    lines = FasterCSV.read(RAILS_ROOT + '/public' + @upload.upload.url, :headers => true, :row_sep => :auto)
    @textout = ''
    lines.each do |row|
      m = Morphbank.new(:species_id => row.fields('species_id').first,
                       :morphbank_code => row.fields('morphbank_code').first,
                       :scamit_unique_id => row.fields('scamit_unique_id').first,
                       :species_name => row.fields('species_name').first,
                       :notes => row.fields('notes').first.to_s,
                       :upload => @upload)
      if m.species_id.nil?
        # find in species table
        genus = row.fields('species_name').first.split(/\s+/).first
        species = row.fields('species_name').first.split(/\s+/).last
        species = Species.find(:all, :conditions => ['genus = ? AND species = ?', genus, species])
        unless species.nil?
          if species.size == 1
            m.species = species.first
          end
        end
      end
      
      # if we still haven't found it, check the synonyms
      if m.species_id.nil?
        # find in species table
        genus = row.fields('species_name').first.split(/\s+/).first
        species = row.fields('species_name').first.split(/\s+/).last
        syn = Synonym.find(:all, :conditions => ['genus = ? AND species = ?', genus, species])
        unless syn.nil?
          m.species_id = syn.first.species_id if syn.size == 1
        end
      end
      
      # check if morphbank id is already in table
      next if Morphbank.exists?(:morphbank_code => m.morphbank_code)
      m.save!
    end
    redirect_to from_file_morphbank_path(@upload)
  end  
  
  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @collection = @uploads ||= Upload.paginate(paginate_options)
    end
    alias :load_and_paginate_resources :collection
    
    def resource
      @resource = @upload ||= Upload.find(params[:id])
    end
    alias :load_resource :resource
    
end