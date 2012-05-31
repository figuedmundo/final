class PlacesController < ApplicationController
  def new
  end

  def show
    @place = Place.first
  end
end
