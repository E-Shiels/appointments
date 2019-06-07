class SessionsController < ApplicationController

  def new
    if logged_in?
      simple_redirect
    end
  end

  def create
    if params[:session]
      if params[:session][:email].present? && params[:session][:password].present?
        doctor = Doctor.find_by(:email => params[:session][:email])
        patient = Patient.find_by(:email => params[:session][:email])
        if doctor && doctor.authenticate(params[:session][:password])
          login_doctor(doctor)
          redirect_to doctor_path(doctor)
        elsif patient && patient.authenticate(params[:session][:password])
          login_patient(patient)
          redirect_to patient_path(patient)
        else
          flash.now[:alert] = "No account found with that email/password combination. Try again."
          render :new
        end
      end
    elsif request.env['omniauth.auth'].present?
      doctor = Doctor.login_with_omniauth(request.env["omniauth.auth"])
      raise params.inspect
      login_doctor(doctor)
      redirect_to edit_doctor_path(doctor)
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out."
    redirect_to root_path
  end

end
