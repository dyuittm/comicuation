class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿を登録しました"
      redirect_to post_path(@post)
    else
      flash[alert] = "投稿できませんでした"
      render :new
    end
  end

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
      redirect_to post_path(@post)
    else
      flash[:alert] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to user_path(current_customer)
  end

  private
  def post_params
    params.require(:post).permit(:body, :image, :tag_body, hashtag_ids: [])
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

end
