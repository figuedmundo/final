class PlacesController < ApplicationController
  # before_filter :loged_in_user
  before_filter :places, only: [:new, :index, :show ]
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
    # @places = Place.all
    @place    = Place.find(params[:id])
    @comment  = @place.comments.build
    @comments = @place.comments
    set_place @place
    
    gon.rabl "app/views/places/show.json.rabl", as: "place"
  end

  def index
    # @places = Place.all
    @title = "Lugares"
    gon.rabl "app/views/places/index.json.rabl", as: "places"
  end

  def finder
    @title = "Finder"

    @places ||= Place.all[0..10]
  end

  def search
    @places = Place.text_search(params[:query])
  end

  def found
    res = Way.path_cost_from(params[:lon_s].to_f, params[:lat_s].to_f, 
                             params[:lon_t].to_f, params[:lat_t].to_f)

    @costo = res[:cost]
    @path = Way.get_way(res[:edges]).to_json
    # @hot_spots = Way.hot_spots(res[:edges]).map {|p| Place.find(p)}.to_json
    @hot = Way.hot_spots(res[:edges])

    @hot_spots = []
    @hot.each do |h|
      p = Place.find(h)
      @hot_spots << Rabl::Renderer.json(p, "places/show", view_path: "app/views")
    end

  end


  private

  def places
    @places = Place.all
  end

end
