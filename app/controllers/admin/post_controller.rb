class Admin::PostController < ApplicationController
  before_action :ensure_correct_admin, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def detroy
  end

  private
  def post_params
    params.require(:post).permit(:body, :image, :tag_body, hashtag_ids: [])
  end

  def ensure_correct_admin
    @post = Post.find(params[:id])
  end


end
