class PhotosController < ApplicationController
  def new
    @place = Place.find(params[:place_id])
    @photo = @place.photos.build
  end

  def create
    @place = Place.find(params[:place_id])
    @photo = @place.photos.build(params[:photo])
    @photo.user = current_user
    if @photo.save
      flash[:success] = "Successfully created..."
      redirect_to @place
    else
      flash.now[:error] = "Error!!"      
      render :new
    end
  end

  def index
    
  end
end
