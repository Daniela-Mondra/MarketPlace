class ProfilesController < ApplicationController
  def show
    @user = current_user
    @reviews = @user.reviews.includes(:sale)
  end
end
