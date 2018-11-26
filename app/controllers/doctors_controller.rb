class DoctorsController < ApplicationController

  def index
    @doctors = Doctor.all
  end

  def show
    find_doctor_from_params
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      session[:user_id] = @doctor.id
      flash[:notice] = "You have successfully signed up."
      redirect_to @doctor
    else
      flash[:notice] = "Signup failed"
      render :new
    end
  end

  def edit
    find_doctor_from_params
  end

  def update
    find_doctor_from_params
    if @doctor.update(doctor_params)
      flash[:notice] = "Doctor was successfully updated."
      redirect_to :root
    else
      flash[:notice] = "Doctor update failed."
      render :new
    end
  end

  def destroy
    find_doctor_from_params
    @doctor.destroy
    redirect_to :root
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name, :gender, :specialty, :practice_name, :practice_location, :phone, :email, :password)
  end

  def find_doctor_from_params
    @doctor = Doctor.find(params[:id])
  end

end
