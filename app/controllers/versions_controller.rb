class VersionsController < ApplicationController
  
  # need some clever pre-loading here to figure out what type of resource we're looking for and pull from the 
  # appropriate xVersions table.  so, a polymorphic controller

  def edit
     @synonym = get_version
     render :template => 'synonyms/edit'
  end
  
  def index
    @versions = versions_from_parent
    @parent = parent_object
    render :template => @parent.class.to_s.tableize.downcase + '/versions'
  end
  
  private
    
    def collection
      paginate_options ||= {}
      paginate_options[:page] ||= (params[:page] || 1)
      paginate_options[:per_page] ||= (params[:per_page] || 20)
      @collection = @synonyms ||= end_of_association_chain.paginate(paginate_options)
    end
    alias :load_and_paginate_resources :collection
    
    def parent_object
      case
        when params[:synonym_id] then Synonym.find(params[:synonym_id])
        when params[:species_id] then Species.find(params[:species_id])
      end
    end
  
    def versions_from_parent
      case
        when params[:synonym_id] then Synonymversion.paginate(:all, :page => params[:page], :per_page => 20, :conditions => ['parent_id = ?', params[:synonym_id]])
        when params[:species_id] then Speciesversion.paginate(:all, :page => params[:page], :per_page => 20, :conditions => ['parent_id = ?', params[:species_id]])
        when params[:news_id] then News.find_by_id(params[:news_id])
      end    
    end
    
    def get_version
      case
        when params[:synonym_id] then Synonymversion.find(params[:id])
        when params[:species_id] then Specisversion.find(params[:id])
      end
    end
  
end