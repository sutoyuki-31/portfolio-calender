class GuestSessionsController < ApplicationController
  def create
    user = User.guest
    sign_in(user)
    redirect_to my_home_path, notice: "ゲストとしてログインしました"
  end
end
