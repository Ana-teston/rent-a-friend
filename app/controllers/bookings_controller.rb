class BookingsController < ApplicationController

  def create
    @booking = Booking.new(bookings_param)
    @friend = Friend.find(params[:friend_id])
    @booking.friend = @friend
    @booking.user = current_user
    @booking.activity = @friend.activity
    @booking.num_of_days = (params[:booking]["end_date(3i)"].to_i - params[:booking]["start_date(3i)"].to_i)
    if @booking.save
      redirect_to friend_path(@booking.friend), notice: "Booking successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private



  def bookings_param
    params.require(:booking).permit(:activity, :start_date, :end_date, :num_of_days)
  end
end
