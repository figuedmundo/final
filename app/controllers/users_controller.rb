class UsersController < ApplicationController
  before_filter :loged_in_user, only: [:edit, :update, :perfil, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

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
    @title = @user.name
  end

  def perfil
    @user = User.find_by_id(params[:id])
    @title = @user.name
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

  def index
    @title = "Usuarios"
    @users = User.all
    # @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User eliminado"
    redirect_to users_path
  end

  private
    def loged_in_user
      unless loged_in?
        store_location
        redirect_to login_path, notice: "Porfavor registrate!!" 
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
