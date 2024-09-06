class SalesController < ApplicationController
  before_action :set_vinyl, only: %i[new create]

  def index
    @user = current_user
    @sales = @user.sales
    
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user

    if @sale.save
      redirect_to sales_path, notice: 'Sales was successfully created.'
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
