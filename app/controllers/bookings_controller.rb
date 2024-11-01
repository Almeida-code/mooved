class BookingsController < ApplicationController
  before_action :set_truck, only: %i[new create]
  before_action :authenticate_user!

  def index
    # Only show bookings that belong to the currently logged-in user
    @bookings = current_user.bookings
  end

  def show
    @trucks = Truck.all # Adjust this to filter by availability if needed
    @booking = Booking.new
  end

  def new
    @truck = Truck.find(params[:truck_id]) # Finds the truck based on the provided truck_id
    @booking = Booking.new
    @trucks = Truck.all # Load all trucks for the dropdown
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user # Associate the booking with the logged-in user
    if @booking.save
      Rails.logger.info "Booking created successfully"
      redirect_to bookings_path, notice: "Booking created successfully!"
    else
      Rails.logger.info "Booking creation failed: #{@booking.errors.full_messages.join(", ")}"
      @trucks = Truck.all # Ensure trucks are reloaded for the form if save fails
      render :new, alert: "Booking could not be created. Please try again."
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "Booking updated successfully!"
    else
      render :edit, alert: "Booking could not be updated. Please try again."
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, status: :see_other, notice: "Booking canceled."
  end

  private

  def set_truck
    @truck = Truck.find(params[:truck_id])
  end

  def booking_params
    params.require(:booking).permit(:truck_id, :start_date, :end_date)
  end
end
