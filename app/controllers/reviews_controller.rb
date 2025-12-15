class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_apartment

  def create
    @review = @apartment.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @apartment, notice: "Review added!"
    else
      redirect_to @apartment, alert: "Could not add review."
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:apartment_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
