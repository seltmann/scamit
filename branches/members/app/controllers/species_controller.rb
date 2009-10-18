class SpeciesController < InheritedResources::Base
 
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  
  before_filter :load_resource, :only => [:show, :edit, :update, :destroy]
  before_filter :load_and_paginate_resources, :only => [:index]
  before_filter :login_required , :only => [:new, :create, :update, :edit, :destroy]
  before_filter :check_edit_perm, :only => [:edit]
  
  def new
      @species = Species.new
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
  
  def search
    if params[:search][:searchterm]
      if params[:search][:searchterm] =~ /^\w+\s+\:\s+\w+$/
        terms = params[:search][:searchterm].split(':')
        @species = Species.paginate(:all, :conditions => ['genus = ? AND species = ?', terms[0].strip, terms[1].strip], :page => params[:page], :per_page => 20)
      else
        @species = Species.paginate(:all, :conditions => 'genus LIKE "%' + params[:search][:searchterm].strip + '%" OR species LIKE "%' + params[:search][:searchterm] + '%"', :page => params[:page], :per_page => 20)
      end
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
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @collection = @species ||= end_of_association_chain.paginate(paginate_options)
    end
    alias :load_and_paginate_resources :collection
    
    def resource
      @resource = @species ||= end_of_association_chain.find(params[:id])
    end
    alias :load_resource :resource
    
end