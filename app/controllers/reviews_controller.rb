class ReviewsController < ApplicationController
  def new
    @friend = Friend.find(params[:friend_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
    @review.friend = @friend
    @review.booking = @booking
  end

  def create
  end

  def destroy
  end
end
