class VinylsController < ApplicationController

  before_action :set_vinyls, only: :show

  def index
    @vinyls = Vinyl.all
  end

  def show
  end

  def new
    @vinyl = Vinyl.new
  end

   def edit
    @vinyl = Vinyl.find(params[:id])
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = current_user

    if @vinyl.save
      redirect_to vinyls_path(@vinyl), notice: 'Vinyl was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @vinyl = Vinyl.find(params[:id])
    redirect_to vinyls_path, notice: 'Vinyl was successfully updated.' if @vinyl.update(vinyl_params)
  end



  def destroy
      @vinyl.destroy
      redirect_to vinyls_path, notice: 'Deleted'
  end

  private

  def set_vinyls
    @vinyl = Vinyl.find(params[:id])
  end

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist, :genre, :price)
  end
end
