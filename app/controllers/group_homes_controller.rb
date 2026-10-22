class GroupHomesController < ApplicationController
  before_action :authenticate_user!

  # グループ内の専用マイホーム(グループ内での表示名・公開設定を反映)
  def show
    @group = current_user.groups.find(params[:group_id])
    @membership = current_user.memberships.find_by!(group: @group)
    @members = @group.memberships.includes(:user).order(role: :desc)
  end
end
