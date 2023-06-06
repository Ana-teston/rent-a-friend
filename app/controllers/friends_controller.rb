class FriendsController < ApplicationController
  def index
    @friends = Friend.all
  end

  def show
    @friend = Friend.find(params[:id])
    @booking = Booking.new
    @review = Review.new
    @reviews = Review.all
    @review.friend = @friend
    @review.booking = @booking
  end

  def new
    @friend = Friend.new
  end

  def create
    @friend = Friend.new(friends_param)
    @friend.user = current_user

    if @friend.save
      redirect_to friend_path(@friend), notice: "Friend created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def friends_param
    params.require(:friend).permit(:interests, :first_name, :last_name, :image, :age, :bio, :location, :price, :activity, :start_date, :end_date)
  end
end
