class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: :show

  def index
    @groups = current_user.groups.order(:name)
  end

  def show
    @membership = current_user.memberships.find_by!(group: @group)
    @members = @group.memberships.includes(:user).order(role: :desc)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params.merge(owner: current_user))
    if @group.save
      redirect_to @group, notice: "グループを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # 所属しているグループだけ参照できる
  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
