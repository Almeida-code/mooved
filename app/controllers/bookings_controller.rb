class BookingsController < ApplicationController
  before_action :set_truck, only: %i[new create]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @truck = Truck.find(@booking.truck_id)
  end

  def new
    @truck = Truck.find(params[:truck_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.truck = @truck
    @booking.save
    redirect_to truck_path(@truck)
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to truck_path(@booking.truck), status: :see_other
  end

  private

  def set_truck
    @truck = Truck.find(params[:truck_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end
