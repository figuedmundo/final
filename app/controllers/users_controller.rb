class UsersController < ApplicationController
  before_filter :loged_in_user, only: [:edit, :update, :perfil]
  before_filter :correct_user, only: [:edit, :update]

  def new
    @title = "Registro"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #hacer algo cuando es guardado con exito
      log_in @user
      flash[:success] = "Bienvenido"
      redirect_to @user
    else
      flash.now[:error] = "Porfavor revisa los errores antes de continuar"
      @title = "Registro"
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    @title = @user.email
  end

  def perfil
    @title = "Perfil"
    @user = User.find_by_id(params[:id])
  end

  def edit
    @title = "Editar perfil"
    # @user = User.find_by_id(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Datos actualizados"
      log_in @user
      redirect_to @user
    else
      # flash.now[:error] = ""
      @title = 'Editar otra vez'
      render :edit
    end
  end

  def delete
  end

  private

    def loged_in_user
      redirect_to login_path, notice: "Porfavor registrate!!" unless loged_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
end
