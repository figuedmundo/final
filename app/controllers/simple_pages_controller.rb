class SimplePagesController < ApplicationController
  
  def home
    @title = 'Home'
    # @user = User.find(params[:id])
  end
end
