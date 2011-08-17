# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
   helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def check_edit_perm
    if current_user
      if current_user.role <= 1
        flash[:error] = 'Sorry, you do not have permission to edit these records.'
        redirect_to '/'
      end
    else
      flash[:error] = 'Sorry, you do not have permission to edit these records.'
      redirect_to '/'
    end
  end

  
end
