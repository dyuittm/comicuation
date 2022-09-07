class Admin::UsersController < ApplicationController
  before_action :ensure_correct_admin, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[notice] = "ユーザー情報を更新しました"
      redirect_to user_path
    else
      flash[alert] = "ユーザー情報を更新できませんでした"
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:last_name, :last_name_kana, :first_name, :first_name_kana, :user_name, :introduction, :profile_image)
  end

  def ensure_correct_admin
    @user = User.find(params[:id])
  end

end
