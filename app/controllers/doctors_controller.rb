class DoctorsController < ApplicationController

  def index
    @doctors = Doctor.all
    #TEMPORARY
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
