class MorphbanksController < InheritedResources::Base
  
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  
  before_filter :load_resource, :only => [:show, :edit, :update, :destroy]
  before_filter :load_and_paginate_resources, :only => [:index]

  def attempt_resolve
    mb = Morphbank.find(params[:id])
    
    # is there a morphbank code?
     
     
    # is there a species name?
    if mb.species_name.blank?
      unless mb.morphbank_code.blank?
        @mystery = mb
        render :partial => 'query_morphbank'
      end
    else
      species_name = mb.species_name.split(/\s+/)
      # check both synonyms and species table, locally
      @species = Species.find(:all, :conditions => ['genus = ? AND species = ?', species_name.first, species_name.last])
      @synonyms = Synonym.find(:all, :conditions => ['genus = ? AND species = ?', species_name.first, species_name.last])
      render :partial => 'query_scamit'
    end
  end
  
  def from_file
    @morphbanks = Morphbank.find(:all, :conditions => ['upload_id = ?', params[:id]])
    render :template => 'morphbanks/imported'
  end
  
  def link_to_species
    if Morphbank.create(:species => Species.find(params[:species_id]), :morphbank_code => params[:id])
      render :text => "record created!  <a href='/species/" + params[:species_id] + "'>go to species record</a>"
    end
  end
  
  def index
    @morphbanks = Upload.find(:all, :conditions => ['uploadtype = "morphbank"'])
  end

  def navigate
    require 'rexml/document'
    case params[:direction]
      when 'fwd'
        @hits = Mb_xml.new(params[:keywords], :first_result => params[:first_result].to_i + params[:num_results_returned].to_i )
      when 'bck'
        @hits = Mb_xml.new(params[:keywords], :first_result => (params[:first_result].to_i - params[:num_results_returned].to_i), :num_results_returned => params[:num_results_returned] )
      when 'start'
        @hits = Mb_xml.new(params[:keywords], :first_result => 0, :num_results_returned => params[:num_results_returned])
      when 'end'
        @hits = Mb_xml.new(params[:keywords], :first_result => params[:num_results].to_i - params[:num_results_returned].to_i  )
    end
    render :template => 'morphbanks/search_morphbank', :layout => false
  end
  
  def new
    
  end
  
  def search_from_species
    require 'rexml/document'
    @species = Species.find(params[:species_id])
    @hits = Mb_xml.new(@species.species)
    render :template => 'morphbanks/search_morphbank'
  end

  def search_morphbank
    require 'rexml/document'
    @species = Species.find(params[:species_id]) if params[:species_id]
    @hits = Mb_xml.new(params[:search])

    
  end

  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @collection = @morphbanks ||= end_of_association_chain.paginate(paginate_options)
    end
    alias :load_and_paginate_resources :collection
    
    def resource
      @resource = @morphbank ||= end_of_association_chain.find(params[:id])
    end
    alias :load_resource :resource
    
end