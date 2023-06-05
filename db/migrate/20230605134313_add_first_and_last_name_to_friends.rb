class AddFirstAndLastNameToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column :friends, :first_name, :string
    add_column :friends, :last_name, :string
  end
end
