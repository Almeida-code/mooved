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

  # def days_booked_by_month
  #   current_date = start_date.beginning_of_month
  #   days_per_month = {}

  #   while current_date <= end_date
  #     month_end = [current_date.end_of_month, end_date].min
  #     days_in_month = (month_end - [current_date, start_date].max).to_i + 1

  #     days_per_month[current_date.strftime("%Y-%m")] = days_in_month

  #     current_date = current_date.next_month.beginning_of_month
  #   end

  #   days_per_month
  # end

  def monthly_revenue

  end


end
