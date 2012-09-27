class SimplePagesController < ApplicationController
  
  def home
    @title = 'Home'
    @user = current_user if loged_in?
    redirect_to finder_path if loged_in?
  end
end
