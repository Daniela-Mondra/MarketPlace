class SalesController < ApplicationController
  before_action :set_vinyl, only: %i[new create]

  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user

    if @sale.save
      redirect_to vinyl_path(params[:vinyl_id]), notice: 'Sales was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_vinyl
    @vinyl = Vinyl.find(params[:vinyl_id])
  end

  def sale_params
    params.require(:sale).permit(:vinyl_id, :user_id)
  end
end
