class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.link_id = params[:link_id]
    if @comment.save
      redirect_to link_url(@comment.link)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to link_url(@comment.link)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.try(:destroy)
    redirect_to link_url(@comment.link)
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end 

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_comment_id)
  end
end
