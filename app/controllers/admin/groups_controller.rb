class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all.order(updated_at: :desc)
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :user_id [])
  end
  
  def ensure_correct_admin
    @group = Group.find(params[:id])
  end

end
