class SessionsController < ApplicationController

  def new
    @title = "Login"
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_back_or root_path
    else
      flash.now[:error] = "Datos invalidos"
      @title = "Login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
