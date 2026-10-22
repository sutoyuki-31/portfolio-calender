class HomeController < ApplicationController
  def index
    redirect_to my_home_path if user_signed_in?
  end
end
