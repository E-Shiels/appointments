class AppointmentsController < ApplicationController
  before_action :login_required
  before_action :find_appointment_from_params, except: [:index, :new, :create]

  def index
    if @current_patient
      @appointments = @current_patient.appointments
    elsif @current_doctor
      @appointments = @current_doctor.appointments
      respond_to do |format|
        format.html {render 'index.html'}
        format.json {render json: @appointments}
      end
    else
      flash[:alert] = "You can't view appointments because you aren't logged in."
      redirect_to root_path
    end
  end

  def show
    if @current_patient
      unless @current_patient = @appointment.patient
        flash[:alert] = "You can't view this appointment."
        redirect_to appointments_path
      end
    elsif @current_doctor
      unless @current_doctor = @appointment.doctor
        flash[:alert] = "You can't view this appointment."
        redirect_to appointments_path
      end
    else
      flash[:alert] = "You can't view appointments because you aren't logged in."
      redirect_to root_path
    end
  end

  def new
    @appointment = Appointment.new
    unless logged_in? && @current_doctor
      flash[:alert] = "You must be signed in as a doctor to create an appointment."
      if !logged_in?
        redirect_to root_path
      else
        redirect_to patient_path(@current_patient)
      end
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @current_doctor
      if @appointment.save
        @appointment.date = Date.parse(params[:appointment][:date]) unless Date.parse(params[:appointment][:date]).nil?
        @appointment.save
        flash[:notice] = "Appointment sucessfully created"
        redirect_to appointment_path(@appointment)
      else
        flash.now[:alert] = "Appointment creation failed"
        render :new
      end
    else
      flash[:alert] = "You can't create an appointment."
      redirect_to patient_path(@current_patient)
    end
  end

  def edit
    if @current_doctor
      unless @current_doctor = @appointment.doctor
        flash[:alert] = "You can't edit this appointment."
        redirect_to appointments_path(@appointment)
      end
    elsif @current_patient
      unless @curent_patient = @appointment.patient
        flash[:alert] = "You can't edit thiss appointment."
        redirect_to appointments_path
      end
    end
  end

  def update
    if @current_patient
      if @current_patient = @appointment.patient
        if @appointment.update(appointment_params)
          flash[:notice] = "Appointment sucessfully updated"
          redirect_to appointment_path(@appointment)
        else
          flash.now[:alert] = "Appointment update failed."
          render :edit
        end
      else
        flash[:alert] = "You can't edit this appointment."
        redirect_to appointments_path
      end
    elsif @current_doctor
      if @current_doctor = @appointment.doctor
        if @appointment.update(appointment_params)
          flash[:notice] = "Appointment sucessfully updated"
          redirect_to appointment_path(@appointment)
        else
          flash.now[:alert] = "Appointment update failed."
          render :edit
        end
      else
        flash[:alert] = "You can't edit this appointment."
        redirect_to appointments_path
      end
    end
  end

  def destroy
    if @current_doctor
      if @current_doctor = @appointment.doctor
        @appointment.destroy
        flash[:notice] = "Appointment sucessfully cancelled."
        redirect_to appointments_path
      else
        flash[:alert] = "You can't cancel this appointment."
        redirect_to appointments_path
      end
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
