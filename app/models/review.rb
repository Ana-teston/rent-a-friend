class Review < ApplicationRecord
  belongs_to :user
  belongs_to :friend
  belongs_to :booking
  validates :title, :body, :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
