class SessionsController < ApplicationController

  def new
  end

  # def create
  #   if params[:email].present? && params[:password].present?
  #     user = Doctor.find_by(:email => params[:email]) || Patient.find_by(:email => params[:email])
  #     if user && user.authenticate(params[:password])
  #       login(user)
  #       if user.is_a?(Appointment)
  #         redirect_to
  #       end
  #     end
  # end

  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out."
    render :new
  end
end
