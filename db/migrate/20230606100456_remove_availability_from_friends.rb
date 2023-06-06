class RemoveAvailabilityFromFriends < ActiveRecord::Migration[7.0]
  def change
    remove_column :friends, :availability
  end
end
