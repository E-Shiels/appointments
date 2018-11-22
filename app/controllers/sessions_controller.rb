class SessionsController < ApplicationController

  def new
  end

  def create
  end

  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out."
    render :new
  end
end
