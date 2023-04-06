class CommentsController < ApplicationController
  #コメントの編集時にコメントを更新できるようにするために入力
  skip_before_action :verify_authenticity_token

  before_action :set_comment, only: %i[update destroy]
  before_action :guest_check
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end
  
  def update
    @comment.update!(comment_update_params)
    render json: @comment
  end
  
  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
