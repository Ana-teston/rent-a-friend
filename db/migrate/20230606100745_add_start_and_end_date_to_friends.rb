class AddStartAndEndDateToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column :friends, :start_date, :date
    add_column :friends, :end_date, :date
  end
end
