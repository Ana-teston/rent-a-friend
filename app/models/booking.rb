class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :friend

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_date_before_end_date, presence: true
  validates :activity, presence: true

  def start_date_before_end_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "The end date can not be before the start date")
    end
  end
end
