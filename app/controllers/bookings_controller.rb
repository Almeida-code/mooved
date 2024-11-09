class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_truck, only: [:new, :create]

  def index
    # Only show bookings that belong to the currently logged-in user
    @bookings = current_user.bookings
  end

  def show
    # `@booking` and `@truck` are set by the `set_booking` method
    @truck = @booking.truck
  end

  def new
    @booking = Booking.new
    if params[:truck_id].present?
      @truck = Truck.find(params[:truck_id]) # Only set @truck if truck_id is provided
      @trucks = [] # Clear trucks list when a specific truck is selected
    else
      @truck = nil # Explicitly set to nil when no truck_id is provided
      @trucks = params[:query].present? ? Truck.search_by_booking(params[:query]) : Truck.all
    end
    logger.debug "Params: #{params.inspect}"
    logger.debug "Truck ID from Params: #{params[:truck_id]}"
    logger.debug "Selected Truck: #{@truck.inspect}"
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to bookings_path, notice: "Booking created successfully!"
    else
      @trucks = Truck.all # Reload trucks for the form if save fails
      render :new, status: :unprocessable_entity, alert: "Booking could not be created due to overlapping dates."
    end
  end

  def edit
    # `@booking` and `@truck` are set by the `set_booking` method
    @truck = @booking.truck
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path, notice: "Booking updated successfully!"
    else
      render :edit, alert: "Booking could not be updated. Please try again."
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      redirect_to bookings_path, notice: "Booking canceled."
    else
      redirect_to bookings_path, alert: "Failed to cancel booking."
    end
  end


  private

  def set_booking
    @booking = Booking.find(params[:id])
    @truck = @booking.truck # Load the associated truck
  end

  def set_truck
    @truck = Truck.find(params[:truck_id]) if params[:truck_id].present?
  end

  def booking_params
    params.require(:booking).permit(:truck_id, :start_date, :end_date)
  end
end
