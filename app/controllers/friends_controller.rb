class FriendsController < ApplicationController
  def index
    @friends = Friend.all
  end

  def show
    puts params[:id]
    @friend = Friend.find(params[:id])
  end

  def new
    @friend = Friend.new
  end

  def create
    @friend = Friend.new(friends_param)
    @friend.user = current_user

    if @friend.save
      redirect_to friend_path(@friend), notice: "friend created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def friends_param
    params.require(:friend).permit(:availability, :interests, :first_name, :last_name, :image, :age, :bio, :location)
  end
end
