class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:email].present? && params[:session][:password].present?
      user = Doctor.find_by(:email => params[:session][:email]) || Patient.find_by(:email => params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        login(user)
        if user.is_a?(Doctor)
          redirect_to doctor_path(user)
        elsif user.is_a?(Patient)
          redirect_to patient_path(user)
        end
      else
        flash.now[:notice] = "Error. Please, try again."
        render :new
      end
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out."
    redirect_to :root
  end
end
