class AddPriceToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column :friends, :price, :integer
  end
end
