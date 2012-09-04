class UsersController < ApplicationController
  before_filter :loged_in_user, only: [:edit, :update, :perfil, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :not_loged_in, only: [:new, :create]
  before_filter :set_places, only: [:show, :perfil, :index]

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
    @comments = @user.comments.all 
    @comment = @user.comments.build
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
    @title  = "Usuarios"
    @users  = User.all
    # @user = User.find(params[:id])
    @user   =  current_user
  end

  def destroy
    user = User.find(params[:id])
    unless user.admin?
      user.destroy
      flash[:notice] = "User eliminado"
    end
      redirect_to users_path
  end

  private


    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def not_loged_in
      redirect_to root_path if loged_in?
    end

    def set_places
      @places = Place.all
    end
end


