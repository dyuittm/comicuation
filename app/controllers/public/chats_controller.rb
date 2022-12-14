class Public::ChatsController < ApplicationController

  def create
    @group = Group.find_by(id: params[:group_id])
    @chat = current_user.chats.new(chat_params)
    @chat.group_id = params[:group_id]
    if @chat.save
      redirect_to group_path(@group.id)
    end
  end

  private
    def chat_params
      params.require(:chat).permit(:message, :group_id, :user_id)
    end

end
