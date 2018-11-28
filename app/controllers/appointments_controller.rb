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
    unless logged_in?
      flash[:notice] = "You must be signed in to create an appointment."
      redirect_to :root
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if logged_in?
      if current_doctor
        if @appointment.save
          flash[:notice] = "Appointment sucessfully created"
          redirect_to @appointment
        else
          flash[:notice] = "Appointment creation failed"
          render :new
        end
      else
        flash[:notice] = "You can't create an appointment."
        redirect_to patient_path(current_patient)
      end
    else
      flash[:notice] = "You need to log in to create an appointment."
      redirect_to :root
    end
  end

  def edit
    find_appointment_from_params
    if logged_in?
      if current_doctor
        unless current_doctor = @appointment.doctor
          flash[:notice] = "You can't edit thiss appointment."
          redirect_to :appointments
        end
      elsif current_patient
        unless curent_patient = @appointment.patient
          flash[:notice] = "You can't edit thiss appointment."
          redirect_to :appointments
        end
      end
      flash[:notice] = "You must be signed in to edit an appointment."
      redirect_to :root
    end
  end

  def update
    find_appointment_from_params
    if logged_in?
      if current_patient
        if current_patient = @appointment.patient
          if @appointment.update(appointment_params)
            flash[:notice] = "Appointment sucessfully updated"
            redirect_to @appointment
          else
            flash[:notice] = "Appointment update failed"
            render :edit
          end
        else
          flash[:notice] = "You can't edit this appointment."
          redirect_to :appointments
        end
      elsif current_doctor
        if current_doctor = @appointment.doctor
          if @appointment.update(appointment_params)
            flash[:notice] = "Appointment sucessfully updated"
            redirect_to @appointment
          else
            flash[:notice] = "Appointment update failed"
            render :edit
          end
        else
          flash[:notice] = "You can't edit this appointment."
          redirect_to :appointments
        end
      else
        redirect_to :root
      end
    end
end

  def destroy
    find_appointment_from_params
    if logged_in?
      if current_doctor
        if current_doctor = @appointment.doctor
          @appointment.destroy
          flash[:notice] = "Appointment sucessfully cancelled"
          redirect_to :appointments
        else
          flash[:notice] = "You can't cancel this appointment."
          redirect_to :appointments
        end
      elsif current_patient
        if current_patient = @appintment.patient
          @appointment.destroy
          flash[:notice] = "Appointment sucessfully cancelled"
          redirect_to :appointments
        else
          flash[:notice] = "You can't cancel this appointment."
          redirect_to :appointments
        end
      end
    else
      redirect_to :root
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:date, :time, :doctor_id, :patient_id, :description)
  end

  def find_appointment_from_params
      @appointment = Appointment.find(params[:id])
  end
end
