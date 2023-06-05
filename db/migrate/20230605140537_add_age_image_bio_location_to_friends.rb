class AddAgeImageBioLocationToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column :friends, :age, :integer
    add_column :friends, :image, :string
    add_column :friends, :bio, :string
    add_column :friends, :location, :string
  end
end
