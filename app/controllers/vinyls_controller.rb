class VinylsController < ApplicationController

  def index
    @vinyls = Vinyl.all
  end

  def edit
    @vinyl = Vinyl.find(params[:id])
  end

  def update
    @vinyl = Vinyl.find(params[:id])
    redirect_to vinyls_path, notice: 'Vinyl was successfully updated.' if @vinyl.update(vinyl_params)
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist, :genre, :price)
  end
end
