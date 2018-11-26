class AppointmentsController < ApplicationController

  def index
    @appointments = Appointment.all
    #@appointments = Appointment.where("patient_id = ?", params[:user_id])
  end

  def show
    find_appointment_from_params
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:notice] = "Appointment sucessfully created"
      redirect_to @appointment
    else
      flash[:notice] = "Appointment creation failed"
      render :new
    end
  end

  def edit
    find_appointment_from_params
  end

  def update
  end

  def destroy
  end

  private
  def appointment_params
    params.require(:appointment).permit(:date, :time, :doctor_id, :patient_id, :description)
  end

  def find_appointment_from_params
      @appointment = Appointment.find(params[:id])
  end
end
