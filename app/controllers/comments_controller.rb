class CommentsController < ApplicationController
  before_filter :loged_in_user
  before_filter :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comentario creado"
      redirect_to current_user
    else
      flash[:error] = "No se puede crear el comentario"
      redirect_to current_user
    end
  end

  def destroy
    @comment.destroy
    redirect_to current_user
  end

  private

    def correct_user
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to current_user if @comment.nil?
    end
end