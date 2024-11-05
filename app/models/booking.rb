class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :truck

  # Validations
  validates :start_date, :end_date, presence: true
  validate :no_date_overlap

  private

  # Custom validation to check for date overlap
  def no_date_overlap
    Rails.logger.info "Checking date overlap for truck_id: #{truck_id}, start_date: #{start_date}, end_date: #{end_date}"

    overlapping_booking = Booking.where(truck_id: truck_id)
                                 .where.not(id: id)
                                 .where("start_date < ? AND end_date > ?", end_date, start_date)

    Rails.logger.info "Found overlapping booking: #{overlapping_booking.inspect}" if overlapping_booking.exists?

    if overlapping_booking.exists?
      errors.add(:base, "The selected truck is already booked for the chosen dates.")
    end
  end

end
