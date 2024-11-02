class TrucksController < ApplicationController
  before_action :set_truck, only: [:show, :edit, :update, :destroy]

  # List all trucks owned by the current customer
  def index
    @trucks = Truck.all  # This fetches all trucks from the database
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
    @truck.destroy
    redirect_to trucks_path, status: :see_other, notice: "Truck deleted successfully."
  end

  private

  # Find the truck by ID and ensure it belongs to the current user
  def set_truck
    @truck = Truck.find(params[:id])
  end

  # Ensure only customers can access these actions
  def authorize_customer
    redirect_to root_path, alert: "Access denied." unless current_user.role == "customer"
  end

  def truck_params
    params.require(:truck).permit(:title, :price, :description, :postcode)
  end
end
