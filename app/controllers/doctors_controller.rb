class DoctorsController < ApplicationController

  def index
    @doctors = Doctor.all
    @doctors.each do |d|
      if d.patients.exclude?(current_patient)
        @doctors.delete(d)
      end
    end
  end

  def show
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
