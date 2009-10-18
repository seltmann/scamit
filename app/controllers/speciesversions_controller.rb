class SpeciesversionsController < ApplicationController 
  
  before_filter :login_required
  
  def approve
    @species = Speciesversion.find(params[:id])
    @approval = true
    if current_user.role > 1
      render 'species/edit'
    else
      flash[:error] = 'You do not have the authorisation to approve this.'
      redirect_to(@species)
    end
  end
  
  
  def edit
    @species = Speciesversion.find(params[:id])
    render 'species/edit'
  end
  
  
  def show
    @species = Speciesversion.find(params[:id])
    @parent = Species.find(@species.parent_id)
    render 'species/compare'
  end
  
  
  def update
    @species = Speciesversion.find(params[:id])
    
    # check if this is sysop approval
    if params[:speciesversion]['approved'] == '1'
      if current_user.role > 1
        # load parent
        params[:speciesversion].delete('approved')
        @parent = Species.find(@species.parent_id)
        params[:speciesversion]['approveddate'] = Time.now
        if @parent.update_attributes(params[:speciesversion])
          @species.approved = 1
          @species.approveddate = Time.now
          @species.approvedby = current_user.id
          if @species.save
            flash[:message] = 'This version has been approved and is now the master species entry.'
            redirect_to @parent
          end
        else
          flash[:error] = 'There was an error approving this version.'
        end
      end
    else
      # not approval, so just edit the existing version.
      # if it's the same user, edit it
      if current_user == @species.user
        if @species.update_attributes(params[:speciesversion])
          redirect_to @species
        end
      else
        # if it's a different user modifying someone else's, save it as a new revision.
        @version = Speciesversion.new(params[:speciesversion])
        @version.user_id = current_user.id
        if @version.save!
          redirect_to @version
        end
      end
    end
  end
  
end