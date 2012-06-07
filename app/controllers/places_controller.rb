class PlacesController < ApplicationController
  def new
    @place = Place.new
    @title = "New lugar"
  end

  def create
    @place = Place.new(params[:place])
    # @place.lat = params[:place][:lat].to_i
    # @place.lng = params[:place][:lng].to_i

    if @place.save
      flash[:notice] = "Successfully created..."
      redirect_to @place
    else
      render :new
    end
  end

  def show
    @place = Place.find(params[:id])
    gon.place_info = @place.name
    gon.x = @place.coord_geographic.x
    gon.y = @place.coord_geographic.y
  end

  def index
    @places = Place.all
    @title = "Lugares"
  end
end
