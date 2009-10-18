# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def can_everything?
    if current_user
      return true if current_user.role.to_i > 3
    end
  end
  
  def can_approve?
    if current_user
      return true if current_user.role.to_i > 2
    end
  end
  
  def can_edit?
    if current_user
      return true if current_user.role.to_i > 1
    end
  end
  
  def compare_values(original, version)
    unless version.blank?
      if original == version
        version
      else
        '<span class="modified">' + version.to_s + '</span>'
      end
    end
  end
  
  def login_or_logout
    if current_user
      return link_to('logout', '/logout')
    else
      return link_to('login', '/login')
    end
  end
  
  def user_or_login
    if current_user
      return "Logged in as " + current_user.login
    else
      link_to('signup for account', '/signup')
    end
  end
  
end
