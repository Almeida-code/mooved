class TrucksController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_customer
  before_action :set_truck, only: [:show, :edit, :update, :destroy, :cancel] # Include :cancel here

  # List all trucks owned by the current customer
  def index
    @trucks = current_user.trucks  # Only display trucks belonging to the logged-in customer
  end

  def show
  end

  def new
    @truck = Truck.new
  end

  def create
    @truck = current_user.trucks.build(truck_params)
    if @truck.save
      respond_to do |format|
        format.html { redirect_to trucks_path, notice: "Truck created successfully!" }
        format.js   # Renders create.js.erb when an Ajax request is made
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @truck.update(truck_params)
      redirect_to truck_path(@truck), notice: "Truck updated successfully!"
    else
      render :edit, alert: "Could not update truck. Please try again."
    end
  end

  def destroy
    @truck = Truck.find(params[:id])
    if @truck.destroy
      redirect_to trucks_path, notice: "Truck deleted."
    else
      redirect_to truck_path, alert: "Failed to delete truck."
    end
  end

  def cancel
    @truck = Truck.find(params[:id])
    if @truck.destroy
      redirect_to trucks_path, notice: "Truck deleted."
    else
      redirect_to truck_path, alert: "Failed to delete truck."
    end
  end

  private

  # Find the truck by ID and ensure it belongs to the current user
  def set_truck
    @truck = current_user.trucks.find(params[:id])  # Raises an error if the truck is not owned by the current user
  end

  # Ensure only customers can access these actions
  def authorize_customer
    redirect_to root_path, alert: "Access denied." unless current_user.role == "company"
  end

  # Permit truck parameters, including photo (optional)
  def truck_params
    params.require(:truck).permit(:title, :price, :description, :postcode, :photo)
  end
end
