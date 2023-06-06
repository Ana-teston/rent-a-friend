class AddActivityToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column :friends, :activity, :string
  end
end
