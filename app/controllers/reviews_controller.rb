class ReviewsController < ApplicationController
  before_action :set_sale, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.sale = @sale

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
