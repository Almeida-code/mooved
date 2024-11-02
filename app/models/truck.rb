class Truck < ApplicationRecord
  has_many :bookings, dependent: :destroy

  # Associate each truck with a specific user (customer)
  belongs_to :user
end
