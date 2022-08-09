class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update
      flash[notice] = "ユーザー情報を更新しました"
      redirect_to user_path
    else
      flash[alert] = "ユーザー情報を更新できませんでした"
      render :edit
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
  end

end
