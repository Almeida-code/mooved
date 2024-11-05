class Truck < ApplicationRecord
  has_many :bookings, dependent: :destroy

  # Associate each truck with a specific user (customer)
  belongs_to :user

  # Allow photo attachment with Active Storage
  has_one_attached :photo

    # Search though bookings
    include PgSearch::Model
    pg_search_scope :search_by_booking,
    against: [ :title, :price, :description, :postcode],
    using: {
      tsearch: { prefix: true }
    }
end
