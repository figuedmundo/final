class PlacesController < ApplicationController
  before_filter :loged_in_user
  
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
      flash.now[:error] = "Te falto algo"
      @title = "New lugar"
      render :new
    end
  end

  def show
    @place = Place.find(params[:id])
    @comment = @place.comments.build
    # session[:place_id] = @place.id
    set_place @place
    
    gon.place_info = @place.name
    gon.x = @place.coord_geographic.x
    gon.y = @place.coord_geographic.y
  end

  def index
    @places = Place.all
    @title = "Lugares"
    gon.rabl "app/views/places/index.json.rabl", as: "places"
  end

  def finder
    @title = "Finder"
  end
end
