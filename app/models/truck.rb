class Truck < ApplicationRecord
  has_many :bookings, dependent: :destroy
  #  belongs_to :client, class_name: 'User'
end
