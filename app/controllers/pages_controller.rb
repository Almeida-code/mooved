class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @trucks = Truck.all # Take all trucks to display on homepage
  end
end
