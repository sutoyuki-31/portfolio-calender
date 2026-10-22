class MyHomesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @groups = current_user.groups.order(:name)
    @memos = current_user.memos.order(updated_at: :desc).limit(5)
    @unread_notifications = current_user.notifications.unread.order(created_at: :desc).limit(5)
  end
end
