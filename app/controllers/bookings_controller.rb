class BookingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @bookings = policy_scope(Booking)
  end

  def create
    @booking = Booking.new(bookings_param)
    @friend = Friend.find(params[:friend_id])
    @booking.friend = @friend
    @booking.user = current_user
    @booking.activity = @friend.activity
    @booking.booking_status = "Pending"
    @booking.num_of_days = (Date.parse(params[:booking]["end_date"]) - Date.parse(params[:booking]["start_date"])).to_i
    authorize @booking

    if @booking.num_of_days > 0 && @booking.save
      redirect_to dashboard_index_path, notice: "Booking successfully created"
    else
      if @booking.num_of_days <= 0
        redirect_to friend_path(@friend), alert: "You can't choose a date before the start date"
      else
        redirect_to friend_path(@friend), status: :unprocessable_entity
      end
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @friend = Friend.find(params[:friend_id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(bookings_param)
    authorize @booking

    redirect_to dashboard_index_path, notice: "Booking successfully updated"
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    authorize @booking

    redirect_to dashboard_index_path, notice: "Booking successfully deleted"
  end

  private


  def bookings_param
    params.require(:booking).permit(:activity, :start_date, :end_date, :num_of_days, :booking_status)
  end
end
