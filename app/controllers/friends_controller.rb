class FriendsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friends = policy_scope(Friend)
    @markers = @friends.geocoded.map do |friend|
      {
        lat: friend.latitude,
        lng: friend.longitude
      }
    end
  end

  def show
    @friend = Friend.find(params[:id])
    @booking = Booking.new
    @review = Review.new
    @reviews = Review.where(friend: params[:id]).order(created_at: :desc)
    @avg = (@reviews.map { |review| review.rating }.sum / @reviews.length).to_i unless @reviews.empty?
    @review.friend = @friend
    @review.booking = @booking
    authorize @friend
  end

  def edit
    @friend = Friend.find(params[:id])
    authorize @friend
  end

  def new
    @friend = Friend.new
    authorize @friend
  end

  def update
    @friend = Friend.find(params[:id])
    @friend.update(friends_param)
    authorize @friend
    redirect_to friend_path(@friend), notice: "Friend updated successfully"
  end

  def create
    @friend = Friend.new(friends_param)
    @friend.user = current_user

    authorize @friend

    if @friend.save
      redirect_to friend_path(@friend), notice: "Friend created successfully"
    else
      render :new, status: :unprocessable_entity, alert: "Could not create a friend"
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy

    authorize @friend
    redirect_to friends_path, notice: "Friend deleted successfully"
  end

  private

  def friends_param
    params.require(:friend).permit(:interests, :first_name, :last_name, :image, :age, :bio, :location, :price, :activity, :start_date, :end_date)
  end
end
