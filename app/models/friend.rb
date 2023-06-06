class Friend < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_date_before_end_date, presence: true
  validates :interests, presence: true
  validates :activity, presence: true
  validates :location, presence: true
  validates :bio, presence: true
  validates :image, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 18 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def start_date_before_end_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "can not be before the start date")
    end
  end
end
