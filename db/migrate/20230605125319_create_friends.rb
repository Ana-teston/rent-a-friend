class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.date :availability
      t.text :interests
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
