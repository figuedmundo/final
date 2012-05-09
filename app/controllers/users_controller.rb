class UsersController < ApplicationController

  def new
    @title = "Registro"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #hacer algo cuando es guardado con exito
      flash[:success] = "Bienvenido"
      redirect_to @user
    else
      flash.now[:error] = "Porfavor revisa los errores antes de continuar"
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
  end

  def update
  end

  def delete
  end
end
