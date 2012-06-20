class CommentsController < ApplicationController
  before_filter :loged_in_user
  before_filter :correct_user, only: :destroy

  def create
    # @place = Place.find_by_id(params[:id])
    # current_view = 
    # @place = Place.find(params[:place_id])
    @comment = current_place.comments.build(params[:comment])
    # @comment = current_place.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comentario creado"
      redirect_to current_place
    else
      flash[:error] = "No se puede crear el comentario #{params}"
      redirect_to current_place
    end
  end

  def destroy
    @comment.destroy
    redirect_to current_place
  end

  private

    def correct_user
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to current_place if @comment.nil?
    end
end