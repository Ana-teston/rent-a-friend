class RemoveCoordinatesFromFriends < ActiveRecord::Migration[7.0]
  def change
    remove_column :friends, :latitude, :float
    remove_column :friends, :longitude, :float
  end
end
