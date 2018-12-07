class PatientsController < ApplicationController
  before_action :login_required, except: [:new, :create]
  before_action :find_patient_from_params, except: [:new, :create]

  def show
    if @current_patient = @patient
      @appointments = Appointment.this_week.where("patient_id = ?", current_patient.id)
    else
      if @current_doctor
        redirect_to doctor_path(@current_doctor)
      elsif @current_patient
        redirect_to patient_path(@current_patient)
      else
        redirect_to root_path
      end
    end
  end

  def new
      if @current_doctor
        redirect_to doctor_path(@current_doctor)
      elsif @current_patient
        redirect_to patient_path(@current_patient)
      end
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)

    if @current_patient
      flash[:alert] = "You already have an account."
      redirect_to patient_path(@current_patient)
    elsif @current_doctor
      flash[:alert] = "You can't create a patient account."
      redirect_to patient_path(@patient)
    end

    if @patient.save
      login_patient(@patient)
      flash[:notice] = "You have successfully signed up."
      redirect_to patient_path(@patient)
    else
      flash.now[:alert] = "Signup failed. Doctor account couldn't be created."
      render :new
    end
  end

  def edit
    if @current_patient
      unless current_patient == @patient
        redirect_to patient_path(@current_patient)
      end
    elsif @current_doctor
      redirect_to doctor_path(@current_doctor)
    else
      redirect_to root_path
    end
  end

  def update
    if @current_patient
      if @current_patient == @patient
        if @patient.update(patient_params)
          flash[:notice] = "Patient details were successfully updated."
          redirect_to patient_path(@patient)
        else
          flash[:alert] = "Patient update failed. Fix the fields indicated by the error messages and try again."
          render :new
        end
      else
        flash[:alert] = "You can't edit another Patients details."
      end
    else
      flash[:alert] = "You can't edit a Patients details."
    end
  end

  def destroy
    if @current_patient
      if @current_patient == @patient
        @patient.destroy
        reset_session
        flash[:notice] = "You have successfully deleted your account."
        redirect_to :root
      else
        flash[:alert] = "You can't delete another Patients account."
      end
    else
      flash[:alert] = "You can't delete a Patient."
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
