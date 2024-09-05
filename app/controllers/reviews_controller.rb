class ReviewsController < ApplicationController
  before_action :set_sale, only: %i[new create]
  def new
    @review = Review.new
  end

  def create
    @review = @sale.build_review(review_params)
    @review.user = current_user

    if @review.save
      redirect_to '/sales', notice: 'Review created successfully!'
    else
      Rails.logger.debug { "Review errors: #{@review.errors.full_messages}" }
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
