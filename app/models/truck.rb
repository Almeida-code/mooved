class Truck < ApplicationRecord
  has_many :bookings, dependent: :destroy

  # Associate each truck with a specific user (customer)
  belongs_to :user

  # Allow photo attachment with Active Storage
  has_one_attached :photo
end
