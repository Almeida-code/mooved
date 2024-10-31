class Booking < ApplicationRecord
  belongs_to :truck
  # belongs_to :customer, class_name: 'User'
end
