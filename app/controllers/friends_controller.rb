class FriendsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friends = policy_scope(Friend)
  end

  def show
    @friend = Friend.find(params[:id])
    @booking = Booking.new
    @review = Review.new
    @reviews = Review.where(friend: params[:id])
    @avg = @reviews.map { |review| review.rating }.sum / @reviews.length
    
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
    redirect_to friend_path(@friend), notice:"updated"
  end

  def create

    cloudinary_response = Cloudinary::Uploader.upload(params[:friend][:image])
    image_key = cloudinary_response["public_id"]

    @friend = Friend.new(friends_param.merge(image: image_key))
    @friend.user = current_user

    authorize @friend

    if @friend.save
      redirect_to friend_path(@friend), notice: "Friend created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy

    authorize @friend
    redirect_to friends_path, notice: "Deleted"
  end

  private

  def friends_param
    params.require(:friend).permit(:interests, :first_name, :last_name, :image, :age, :bio, :location, :price, :activity, :start_date, :end_date)
  end
end
