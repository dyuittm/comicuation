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
  end

  def ensure_correct_admin
    @user = User.find(params[:id])
  end

end
