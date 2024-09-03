class VinylsController < ApplicationController

  def index
    @vinyls = Vinyl.all
  end

  def destroy
    @vinyl.destroy
    redirect_to vinyls_path, notice: 'Deleted'
  end
end
