class VinylsController < ApplicationController
  before_action :set_vinyls, only: :show
  def index
    @vinyls = Vinyl.all
  end

  def show
  end

  private

  def set_vinyls
    @vinyl = Vinyl.find(params[:id])
  end
end
