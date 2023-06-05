class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @booking.friend = params[:friend_id]
  end

  def create
    @booking = Booking.new(bookings_param)
    @booking.friend = params[:friend_id]
    @booking.user = current_user
    if @booking.save
      redirect_to friend_path(@booking.friend), notice: "booking created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def bookings_param
    params.require(:booking).permit(:date, :activity)
  end

end
