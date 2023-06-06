class AddNumOfDaysToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :num_of_days, :integer
  end
end
