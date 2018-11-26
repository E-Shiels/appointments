class PatientsController < ApplicationController

  def show
    find_patient_from_params
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new
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
  end

  def update
    find_patient_from_params
    if @patient.update(patient_params)
      flash[:notice] = "Patient was successfully updated."
      redirect_to :root
    else
      flash[:notice] = "Patient update failed."
      render :new
    end
  end

  def destroy
    find_patient_from_params
    @patient.destroy
    redirect_to :root
  end

  private
  def patient_params
    params.require(:patient).permit(:name, :gender, :age, :address, :phone, :email, :password)
  end

  def find_patient_from_params
    @patient = Patient.find(params[:id])
  end

end
