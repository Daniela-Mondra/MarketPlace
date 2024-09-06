class ReviewsController < ApplicationController
  before_action :set_sale, only: %i[new create]

  def new
    @review = @sale.reviews.new
  end

  def create
    @review = @sale.reviews.new(review_params)
    #@review.user = @sale.vinyl.user
    

    if @review.save
      redirect_to sales_path, notice: 'Review created successfully!'
    else
      render :new
    end
  end

  private

  def set_sale
    @sale = Sale.find(params[:sale_id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
