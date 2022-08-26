class Public::ChatsController < ApplicationController

  def show
    @user = User.find(params[:id])
    @group = Group.find(params[:id])
    @chats = @group.chats
    @chat = Chat.new(group_id: @group.id)
  end

  def create
    @group = Group.find(params[:id])
  　@chat = @group.user.chats.new(chat_params)
  　@chat.saves
  end

  private

  def chat_params
   params.require(:chat).permit(:message, :group_id, :user_id)
  end

end
