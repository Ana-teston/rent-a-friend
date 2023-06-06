class Friend < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :start_date, :end_date, :interests,
  :activity, :location, :bio, :image, :first_name, :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 18 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def start_date_before_end_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "can not be before the start date")
    end
  end
end
