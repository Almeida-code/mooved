class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @trucks = Truck.all
    @resource = User.new
  end
end
