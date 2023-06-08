class Friend < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  validates :start_date, :end_date, :interests,
  :activity, :location, :bio, :first_name, :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 18 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  has_one_attached :image

end
