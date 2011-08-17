class SpeciesController < InheritedResources::Base
 
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  
  before_filter :load_resource, :only => [:show, :edit, :update, :destroy]
  before_filter :load_and_paginate_resources, :only => [:index]
  before_filter :login_required , :only => [:new, :create, :update, :edit, :destroy]
  before_filter :check_edit_perm, :only => [:edit]
  helper :species
  
  def filter
    if params[:id].blank?
      return
    end
    @species = Species.paginate(:all, :conditions => ["#{params[:field]} = ?", params[:id]], :page => params[:page], :per_page => 20)
    if params[:field] == 'theclass'
      @jq = "$('#phylum_filter').val('#{@species.first.phylum}');"
    elsif   params[:field] == 'phylum'
        @jq = "$('#class_filter').val('');"
    elsif params[:field] == 'family'
      @jq = "$('#family_filter').val('');"
    end
    render :partial => 'filtered'
  end
  
  


  def index
    if params[:q]
      @resource = Species.find(:all, :conditions => 'genus like "%' + params[:q] + '%" OR species LIKE "%' + params[:q] + '%"')
    end
    
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end
  
  
  def link_to_morphbank
    if Morphbank.create(:species => Species.find(params[:id]), :morphbank_code => params[:morphbank_id])
      render :text => "record created!  <a href='/species/" + params[:id] + "'>go to species record</a>"
    end
  end
  
  
  
  def new
      @species = Species.new
  end
  

  
  
  def search
    if params[:search][:searchterm]
      if params[:search][:searchterm] =~ /^\w+\s\w+$/
        terms = params[:search][:searchterm].split(/\s/)
        species = Species.find(:all, :conditions => ['genus = ? AND species = ?', terms[0].strip, terms[1].strip])
        synonyms = Synonym.find(:all, :conditions => ['genus = ? AND the_species = ?', terms[0].strip, terms[1].strip])
        synonyms.each do |s|
          species.push(s.species)
        end
      else
        species = Species.find(:all, :conditions => 'genus LIKE "%' + params[:search][:searchterm].strip + '%" OR species LIKE "%' + params[:search][:searchterm] + '%"')
        synonyms = Synonym.find(:all, :conditions => 'genus LIKE "%' + params[:search][:searchterm].strip + '%" OR the_species LIKE "%' + params[:search][:searchterm] + '%"')
      
     
        synonyms.each do |s|
          species.push(s.species)
        end
      end
      @species = species.uniq.paginate(:page => params[:page], :per_page => 20)
    end
    render :action => :index
  end
  
  
  def update
   @version = Speciesversion.new(params[:species])
   @version.user_id = current_user.id
   @version.parent_id = params[:id]
   @version.save!
   redirect_to '/species' 
  end
  
  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 50)
      @collection = @species ||= end_of_association_chain.paginate(paginate_options)
    end
    alias :load_and_paginate_resources :collection
    
    def resource
      @resource = @species ||= end_of_association_chain.find(params[:id])
    end
    alias :load_resource :resource
    
end