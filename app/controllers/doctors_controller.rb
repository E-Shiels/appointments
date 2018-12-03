class DoctorsController < ApplicationController
  #before_action :login_required, except: [:index, :show, :new, :create]

  def index
    @doctors = Doctor.all
  end

  def show
      find_doctor_from_params
  end

  def new
    if logged_in?
      doctor = Doctor.find_by_id(session[:doctor_id])
      patient = Patient.find_by_id(session[:patient_id])
      if doctor
        flash[:alert] = "You already have an account."
        redirect_to doctor_path(doctor)
      elsif patient
        flash[:alert] = "You can't create a Doctor account."
        redirect_to patient_path(patient)
      end
    end
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if logged_in?
      doctor = Doctor.find_by_id(session[:doctor_id])
      patient = Patient.find_by_id(session[:patient_id])
      if doctor
        flash[:alert] = "You already have an account."
        redirect_to doctor_path(doctor)
      elsif patient
        flash[:alert] = "You can't create a Doctor account."
        redirect_to patient_path(patient)
      end
    elsif @doctor.save
      session[:doctor_id] = @doctor.id
      flash[:notice] = "You have successfully signed up."
      redirect_to @doctor
    else
      flash[:alert] = "Signup failed"
      render :new
    end
  end

  def edit
    find_doctor_from_params
    if current_doctor
      unless current_doctor == @doctor
        redirect_to doctor_path(current_doctor)
      end
    elsif current_patient
      redirect_to patient_path(current_patient)
    else
      redirect_to :root
    end
  end

  def update
    find_doctor_from_params
    if current_doctor
      if current_doctor == @doctor
        if @doctor.update(doctor_params)
          flash[:notice] = "Doctor details were successfully updated."
          redirect_to @doctor
        else
          flash[:alert] = "Doctor update failed."
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
    find_doctor_from_params
    if current_doctor
      if current_doctor == @doctor
        @doctor.destroy
        reset_session
        flash[:notice] = "You have successfully deleted your account."
        redirect_to :root
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
    @doctor = Doctor.find(params[:id])
  end

end
