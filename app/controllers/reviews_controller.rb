class ReviewsController < ApplicationController
  def new
    @friend = Friend.find(params[:friend_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
    @review.friend = @friend
    @review.booking = @booking
  end

  def create
    @friend = Friend.find(params[:friend_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.friend = @friend
    @review.booking = @booking
    @review.user = current_user

    if @review.save
      redirect_to friend_path(@friend), notice: "Review successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to friend_path(@review.friend)
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end
end
