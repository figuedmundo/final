class PlacesController < ApplicationController
  before_filter :loged_in_user
  # respond_to :js, only: :found
  # include PlacesHelper
  
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
    @place    = Place.find(params[:id])
    @comment  = @place.comments.build
    @comments = @place.comments
    set_place @place
    
    gon.rabl "app/views/places/show.json.rabl", as: "place"
  end

  def index
    @places = Place.all
    @title = "Lugares"
    gon.rabl "app/views/places/index.json.rabl", as: "places"
  end

  def finder
    @title = "Finder"

    @places ||= Place.all

    # query_places
    # if params[:lon_s] && params[:lat_s]
      
    #   res = Way.path_cost_from(params[:lon_s].to_f, params[:lat_s].to_f, 
    #                            params[:lon_t].to_f, params[:lat_t].to_f)

    #   @costo = res[:cost]
    #   gon.poly = Way.get_way(res[:edges])

    # end

  end

  def search
    @places = Place.text_search(params[:query])
  end

  def found
    res = Way.path_cost_from(params[:lon_s].to_f, params[:lat_s].to_f, 
                             params[:lon_t].to_f, params[:lat_t].to_f)

    @costo = res[:cost]
    @path = Way.get_way(res[:edges]).to_json
  end


  private

end
