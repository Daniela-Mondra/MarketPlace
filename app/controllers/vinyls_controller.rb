class VinylsController < ApplicationController
  before_action :set_vinyls, :set_vinyls_by_genre, only: %i[destroy show edit update]
  before_action :set_vinyls_by_genre, only: :genre
  def home
    @vinyls = Vinyl.all.order(created_at: :desc)
    if params[:query].present?
      sql_subquery = "title ILIKE :query OR artist ILIKE :query"
      @vinyls = @vinyls.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def index
    @vinyls = Vinyl.all.order(created_at: :desc)
  end

  def show
    @vinyls = Vinyl.where(genre: @vinyl.genre).excluding(@vinyl)
  end

  def new
    @vinyl = Vinyl.new
  end

  def edit
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
    redirect_to vinyls_path, notice: 'Vinyl was successfully updated.' if @vinyl.update(vinyl_params)
  end

  def destroy
    @vinyl.destroy
    flash[:notice] = 'Vinyl was deleted.'
    redirect_to vinyls_path
  end

  def genre
    set_vinyls_by_genre
  end

  private

  def set_vinyls
    @vinyl = Vinyl.find(params[:id])
  end

  def set_vinyls_by_genre
    @genre = params[:genre].capitalize
    @vinyls = Vinyl.where(genre: @genre)
    puts "Género musical: #{@genre}"
  end

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist, :genre, :price, :photo, :description)
  end
end
