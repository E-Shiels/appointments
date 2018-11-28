class SessionsController < ApplicationController
  def new
    if logged_in?
      doctor = Doctor.find_by_id(session[:doctor_id])
      patient = Patient.find_by_id(session[:patient_id])
      if doctor
        redirect_to doctor_path(doctor)
      elsif patient
        redirect_to patient_path(patient)
      end
    end
  end

  def create
    if params[:session][:email].present? && params[:session][:password].present?
      doctor = Doctor.find_by(:email => params[:session][:email])
      patient = Patient.find_by(:email => params[:session][:email])
      if doctor && doctor.authenticate(params[:session][:password])
        login_doctor(doctor)
        redirect_to doctor_path(doctor)
      elsif patient && patient.authenticate(params[:session][:password])
        login_patient(patient)
          redirect_to patient_path(patient)
      end
    elsif request.env['omniauth.auth'].present?
      raise params.inspect
    else
        flash.now[:notice] = "Error. Please, try again."
        render :new
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out."
    redirect_to :root
  end
end
