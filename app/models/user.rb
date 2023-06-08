class User < ApplicationRecord
  has_many :bookings
  has_one :review, dependent: :destroy
  has_one :friend
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
