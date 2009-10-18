class SynonymversionsController < ApplicationController 
  
  before_filter :login_required
  
  def approve
    @synonym = Synonymversion.find(params[:id])
    @approval = true
    if current_user.role > 1
      render 'synonyms/edit'
    else
      flash[:error] = 'You do not have the authorisation to approve this.'
      redirect_to(@synonym)
    end
  end
  
  
  def edit
    @synonym = Synonymversion.find(params[:id])
    render 'synonyms/edit'
  end
  
  
  def show
    @synonym = Synonymversion.find(params[:id])
    @parent = Synonym.find(@synonym.parent_id)
    render 'synonyms/compare'
  end
  
  
  def update
    @synonym = Synonymversion.find(params[:id])
    
    # check if this is sysop approval
    if params[:synonymversion]['approved'] == '1'
      if current_user.role > 1
        # load parent
        params[:synonymversion].delete('approved')
        @parent = Synonym.find(@synonym.parent_id)
        params[:synonymversion]['approveddate'] = Time.now
        if @parent.update_attributes(params[:synonymversion])
          @synonym.approved = 1
          @synonym.approveddate = Time.now
          @synonym.approvedby_id = current_user.id
          if @synonym.save
            flash[:message] = 'This version has been approved and is now the master synonym entry.'
            redirect_to @parent
          end
        else
          flash[:error] = 'There was an error approving this version.'
        end
      end
    else
      # not approval, so just edit the existing version.
      # if it's the same user, edit it
      if current_user == @synonym.user
        if @synonym.update_attributes(params[:synonymversion])
          redirect_to @synonym
        end
      else
        # if it's a different user modifying someone else's, save it as a new revision.
        @version = Synonymversion.new(params[:synonymversion])
        @version.user_id = current_user.id
        if @version.save!
          redirect_to @version
        end
      end
    end
  end
  
end