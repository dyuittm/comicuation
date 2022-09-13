class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all.order(updated_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
  end

end
