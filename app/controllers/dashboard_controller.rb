class DashboardController < ApplicationController
  def index
    @total_bookings = current_user.bookings.count
    @total_trucks = current_user.trucks.count
    @trucks = current_user.trucks
    @sum_of_bookings = 0

    @trucks.each do |truck|
      truck.bookings.each do |booking|
        amount = (booking.end_date - booking.start_date).to_i * truck.price
        @sum_of_bookings += amount
      end
    end
  end
end
