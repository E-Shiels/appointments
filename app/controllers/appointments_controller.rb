class AppointmentsController < ApplicationController

  def index
    @appointments = Appointment.all
    #@appointments = Appointment.where("patient_id = ?", params[:user_id])
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
  end

  def create
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
  end

  def destroy
  end

end
