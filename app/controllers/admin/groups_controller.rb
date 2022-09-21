class Admin::GroupsController < ApplicationController
  before_action :ensure_correct_admin, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all.order(updated_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to admin_groups_path
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :user_id [])
  end

  def ensure_correct_admin
    @group = Group.find(params[:id])
  end

end
