class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:show, :edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = '退会処理を実行いたしました'
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:last_name, :last_name_kana, :first_name, :first_name_kana, :user_name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.user_name == "guestuser"
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      redirect_to user_path(current_user)
    end
  end

end
