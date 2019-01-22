class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_doctor, :current_patient
  helper_method :logged_in?, :current_doctor, :current_patient

  def login_doctor(doctor)
    session[:doctor_id] = doctor.id
  end

  def login_patient(patient)
    session[:patient_id] = patient.id
  end

  def login_required
    if !logged_in?
      flash[:alert] = "Please login to view that page."
      redirect_to login_path
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

  def current_doctor
    @current_doctor ||= Doctor.find(session[:doctor_id]) if session[:doctor_id].present?
  end

  def current_patient
    @current_patient ||= Patient.find(session[:patient_id]) if session[:patient_id].present?
  end

  def simple_redirect
    if @current_doctor
      redirect_to doctor_path(@current_doctor)
    elsif @current_patient
      redirect_to patient_path(@current_patient)
    end
  end

end
