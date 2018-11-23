class DoctorsController < ApplicationController

  def index
    #BROKEN
    @doctors = Doctor.all
    @doctors.each do |d|
      if d.patients.exclude?(current_patient)
        @doctors.delete(d)
      end
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
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

end
