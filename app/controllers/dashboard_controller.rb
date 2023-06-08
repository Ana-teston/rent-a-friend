class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @bookings = policy_scope(Booking.where(user: current_user))
    @friend = Friend.where(user: current_user).first
  end
end
