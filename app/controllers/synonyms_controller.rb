class SynonymsController < InheritedResources::Base
  
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  
  before_filter :load_resource, :only => [:show, :edit, :update, :destroy]
  before_filter :login_required, :only => [:edit]
  before_filter :load_and_paginate_resources, :only => [:index]
  
  def update
   @version = Synonymversion.new(params[:synonym])
   @version.user_id = current_user.id
   @version.parent_id = params[:id]
   @version.save!
   redirect_to '/synonyms' 
  end
  

  protected
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @collection = @synonyms ||= end_of_association_chain.paginate(paginate_options)
    end
    alias :load_and_paginate_resources :collection
    
    def resource
      @resource = @synonym ||= end_of_association_chain.find(params[:id])
    end
    alias :load_resource :resource
    
end