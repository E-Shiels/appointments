class PatientsController < ApplicationController

  def show
    find_patient_from_params
    if logged_in?
      if current_patient = @patient

      else
      doctor = Doctor.find_by_id(session[:doctor_id])
      patient = Patient.find_by_id(session[:patient_id])
      if doctor
        redirect_to doctor_path(doctor)
      elsif patient
        redirect_to patient_path(patient)
      else
        redirect_to :root
      end
    end
    else
    redirect_to :root
    end
  end

  def new
    if logged_in?
      doctor = Doctor.find_by_id(session[:doctor_id])
      patient = Patient.find_by_id(session[:patient_id])
      if doctor
        redirect_to doctor_path(doctor)
      elsif patient
        redirect_to patient_path(patient)
      end
    end
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      session[:user_id] = @patient.id
      flash[:notice] = "You have successfully signed up."
      redirect_to @patient
    else
      flash[:notice] = "Signup failed"
      render :new
    end
  end

  def edit
    find_patient_from_params
    if current_patient
      unless current_patient == @patient
        redirect_to patient_path(current_patient)
      end
    elsif current_doctor
      redirect_to doctor_path(current_doctor)
    else
      redirect_to :root
    end
  end

  def update
    find_patient_from_params
    if current_patient
      if current_patient == @patient
        if @patient.update(patient_params)
          flash[:notice] = "Patient details were successfully updated."
          redirect_to :root
        else
          flash[:notice] = "Patient update failed."
          render :new
        end
      else
        flash[:notice] = "You can't edit another Patients details."
      end
    else
      flash[:notice] = "You can't edit a Patients details."
    end
  end

  def destroy
    find_patient_from_params
    if current_patient
      if current_patient == @patient
        @patient.destroy
        reset_session
        flash[:notice] = "You have successfully deleted your account."
        redirect_to :root
      else
        flash[:notice] = "You can't delete another Patients account."
      end
    else
      flash[:notice] = "You can't delete a Patient."
    end
  end

  private
  def patient_params
    params.require(:patient).permit(:name, :gender, :age, :address, :phone, :email, :password)
  end

  def find_patient_from_params
    @patient = Patient.find(params[:id])
  end

end
