class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def new
    @friend = Friend.find(params[:friend_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
    @review.friend = @friend
    @review.booking = @booking
    authorize @review
  end

  def create
    @friend = Friend.find(params[:friend_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.friend = @friend
    @review.booking = @booking
    @review.user = current_user
    authorize @review

    if @review.save
      redirect_to friend_path(@friend), notice: "Review successfully created"
    else
      render :new, status: :unprocessable_entity, alert: "Could not create a review"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to friend_path(@review.friend), notice: "Review successfully deleted"
    authorize @review
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end
end
