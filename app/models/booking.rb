class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :friend
  has_one :review, dependent: :destroy
  validates :activity, :start_date, :end_date, presence: true

  STATUS = ['pending', 'confirmed', 'finished', 'canceled'].freeze
  validates :status, presence: true

  def start_date_before_end_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "The end date can not be before the start date")
    end
  end
end
