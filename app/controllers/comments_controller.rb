class CommentsController < ApplicationController
  before_filter :loged_in_user

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
    
  end
end