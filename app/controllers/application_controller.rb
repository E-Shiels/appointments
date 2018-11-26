class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_doctor
  before_action :current_patient

  def login_doctor(doctor)
    session[:doctor_id] = doctor.id
  end

  def login_patient(patient)
    session[:patient_id] = patient.id
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
    @current_doctor ||= Doctor.find(session[:doctor_id]) if session[:doctor_id].present?
  end
    helper_method :current_doctor

  def current_patient
    @current_patient ||= Patient.find(session[:patient_id]) if session[:patient_id].present?
  end
    helper_method :current_patient


end
