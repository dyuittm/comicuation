class Public::GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def index
    @groups = Group.all.order(updated_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    groups = current_user.group_users.pluck(:group_id)
    group_users = GroupUser.find_by(user_id: @user.id, group_id: groups)
    @group = Group.find(params[:id])
    @chats = @group.chats
    @chat = Chat.new(group_id: @group.id)
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:notice] = "削除しました"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :user_id [])
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
