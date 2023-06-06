class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new(bookings_param)
    @friend = Friend.find(params[:friend_id])
    @booking.friend = @friend
    @booking.user = current_user
    @booking.activity = @friend.activity
    @booking.num_of_days = (params[:booking]["end_date(3i)"].to_i - params[:booking]["start_date(3i)"].to_i)
    if @booking.save
      redirect_to bookings_path, notice: "Booking successfully created"
    else
      redirect_to friend_path(@friend), status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @friend = Friend.find(params[:friend_id])

  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(bookings_param)

    redirect_to bookings_path, notice: "Booking successfully updated"
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: "Booking successfully deleted"

  end

  private



  def bookings_param
    params.require(:booking).permit(:activity, :start_date, :end_date, :num_of_days)
  end
end
