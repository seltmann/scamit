class UsersController < ApplicationController
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :login_required , :only => [:index, :edit, :update, :destroy]

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def edit
    if current_user.role > 3
      @user = User.find(params[:id])
    else
      flash[:error] = 'Sorry, you don\'t have permission to edit user information.'
      redirect_to '/'
    end
  end
  
  
  def update
    if current_user.role > 3
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user]) 
        flash[:notice] = 'User information edited.'
        redirect_to @user
      else
        flash[:error] = 'Error saving user information.'
        redirect_to edit_user_path(@user)
      end
    else
      flash[:error] = 'Sorry, you don\'t have permission to edit other user information.'
      redirect_to '/'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.paginate :page => params[:page], :per_page => 20
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
            redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def suspend
   if current_user.role > 3
     @user.suspend! 
     redirect_to users_path
    end
  end

  def unsuspend
   if current_user.role > 3
     @user.unsuspend! 
     redirect_to users_path
    end
  end

  def destroy
    if current_user.role > 3
      @user.delete!
      redirect_to users_path
    end
  end

  def purge
    if current_user.role > 3
      @user.destroy
      redirect_to users_path
    end
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
