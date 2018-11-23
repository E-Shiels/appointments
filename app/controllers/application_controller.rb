class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login(user)
    session[:user_id] = user.id
  end

  def login_required
    if !logged_in?
      redirect_to login_path, :notice => "Please login to view that page."
    end
  end


  def logged_in?
    if !current_doctor.nil?
      !!current_doctor
    elsif !current_patient.nil?
      !!current_patient
    else
      false
    end
  end
    helper_method :logged_in?

  def current_doctor
    @current_doctor ||= Doctor.find(sessions[:user_id]) if sessions[:user_id].present?
  end
    helper_method :current_doctor

  def current_patient
    @current_patient ||= Patient.find(sessions[:user_id]) if sessions[:user_id].present?
  end
    helper_method :current_patient


end
