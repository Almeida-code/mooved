class Truck < ApplicationRecord
  has_many :bookings, dependent: :destroy

  # Associate each truck with a specific user (customer)
  belongs_to :user

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :postcode, presence: true
end
