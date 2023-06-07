class Review < ApplicationRecord
  belongs_to :user
  belongs_to :friend
  belongs_to :booking

end
