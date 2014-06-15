class Api::CommentsController < ApplicationController
  def index
    render json: Comment
    .where("body is not null")
    .where(:proceeding_number => '14-28')
    .order(view_id: :desc)
  end

  def show
    render json: Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.save!(params)
      render json: @post
    end
  end
end
