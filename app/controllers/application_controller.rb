class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login(user)
    sessions[:user_id] = user.id
  end

  def login_required
    if !logged_in?
      redirect_to login_path, :notice => "Please login to view that page."
    end
  end


  def logged_in?
    !!current_user
  end
    helper_method :logged_in?

  def current_user
    @current_user ||= User.find(sessions[:user.id]) if sessions[:user_id].present?
  end
    helper_method :current_user

end
