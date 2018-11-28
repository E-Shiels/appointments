class AppointmentsController < ApplicationController

  def index
    if logged_in?
      if current_patient
        @appointments = Appointment.where("patient_id = ?", current_patient.id)
      elsif current_doctor
        @appointments = Appointment.where("doctor_id = ?", current_doctor.id)
      end
    else
      flash[:notice] = "You can't view appointments becuase you aren't logged in."
      redirect_to :root
    end
  end

  def show
    find_appointment_from_params
    if logged_in?
      if current_patient
        unless current_patient = @appointment.patient
          flash[:notice] = "You can't view this appointment."
          redirect_to :appointments
        end
      elsif current_doctor
        unless current_doctor = @appointment.doctor
          flash[:notice] = "You can't view this appointment."
          redirect_to :appointments
        end
      end
    else
      flash[:notice] = "You can't view appointments becuase you aren't logged in."
      redirect_to :root
    end
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
    find_appointment_from_params
    if @appointment.update(appointment_params)
      flash[:notice] = "Appointment sucessfully updated"
      redirect_to @appointment
    else
      flash[:notice] = "Appointment update failed"
      render :edit
    end
  end

  def destroy
    find_appointment_from_params
    @appointment.destroy
    redirect_to :appointments_path
  end

  private
  def appointment_params
    params.require(:appointment).permit(:date, :time, :doctor_id, :patient_id, :description)
  end

  def find_appointment_from_params
      @appointment = Appointment.find(params[:id])
  end
end
