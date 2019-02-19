class DoctorsController < ApplicationController
  before_action :login_required, except: [:index, :show, :new, :create]
  before_action :find_doctor_from_params, except: [:index, :new, :create]

  def index
    @doctors = Doctor.all
    respond_to do |format|
      format.html { render 'index.html' }
      format.json { render json: @doctors}
    end
  end

  def show
    if @current_doctor && @current_doctor = find_doctor_from_params
      @appointments = Appointment.today.where("doctor_id = ?", current_doctor.id)
      @appointment = Appointment.new
    else
      @appointments = nil
    end
  end

  def new
    if @current_doctor
      flash[:alert] = "You already have an account."
      redirect_to doctor_path(@current_doctor)
    elsif @current_patient
      flash[:alert] = "You can't create a Doctor account."
      redirect_to patient_path(@current_patient)
    end
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @current_doctor
      flash[:alert] = "You already have an account."
      redirect_to doctor_path(@current_doctor)
    elsif @current_patient
      flash[:alert] = "You can't create a Doctor account."
      redirect_to patient_path(patient)
    end

    if @doctor.save
      login_doctor(@doctor)
      flash[:notice] = "You have successfully signed up."
      redirect_to doctor_path(@doctor)
    else
      flash.now[:alert] = "Signup failed. Doctor account couldn't be created."
      render :new
    end
  end

  def edit
    if @current_doctor
      unless @current_doctor == @doctor
        redirect_to doctor_path(@current_doctor)
      end
    elsif @current_patient
      redirect_to patient_path(@current_patient)
    else
      redirect_to root_path
    end
  end

  def update
    if @current_doctor
      if @current_doctor == @doctor
        if @doctor.update(doctor_params)
          flash[:notice] = "Doctor details were successfully updated."
          redirect_to doctor_path(@doctor)
        else
          flash.now[:alert] = "Doctor update failed. Fix the fields indicated by the error messages and try again."
          render :new
        end
      else
        flash[:alert] = "You can't edit another Doctors details."
      end
    else
      flash[:alert] = "You can't edit a Doctors details."
    end
  end

  def destroy
    if @current_doctor
      if @current_doctor == @doctor
        @doctor.destroy
        reset_session
        flash[:notice] = "You have successfully deleted your account."
        redirect_to root_path
      else
        flash[:alert] = "You can't delete another Doctors account."
      end
    else
      flash[:alert] = "You can't delete a Doctor."
    end
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name, :gender, :specialty, :practice_name, :practice_location, :phone, :email, :password)
  end

  def find_doctor_from_params
    @doctor = Doctor.friendly.find(params[:id])
  end

end
