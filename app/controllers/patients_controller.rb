class PatientsController < ApplicationController

  def show
    @patient = Patient.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def patient_params
    params.require(:patient).permit(:name, :gender, :age, :address, :phone, :email, :password)
  end

end
