class TypePlacesController < ApplicationController
  
  def new
    @title = "Nueva clasificacion de lugares"
    @type_place = TypePlace.new()
  end

  def create
    @type_place = TypePlace.new(params[:type_place])
    if @type_place.save
      flash[:success] = "Successfully created..."
      redirect_to new_type_place_path
    else
      flash.now[:error] = "Algo esta mal.."
      render :new
    end
  end



end
