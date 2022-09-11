class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all.order(updated_at: :desc)
  end


end
