class UsersController < ApplicationController

  def new
    @title = "Registro"
    @user = User.new
  end

  def create
    @user = User.new
    flash.now[:error] = "#{params}"
    render :new
  end

  def edit
  end

  def update
  end

  def delete
  end
end
