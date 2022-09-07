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
    if @post.update(post_params)
      flash[:notice] = '投稿を更新しました'
      redirect_to admin_post_path(@post)
    else
      flash[:alert] = '更新できませんでした'
      render :edit
    end
  end

  def detroy
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to admin_user_path(@post.user)
  end

  private
  def post_params
    params.require(:post).permit(:body, :image, :tag_body, hashtag_ids: [])
  end

  def ensure_correct_admin
    @post = Post.find(params[:id])
  end


end
