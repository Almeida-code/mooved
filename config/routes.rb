Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users
  root to: "pages#home"

  get 'dashboard', to: 'dashboard#index'

  # Nested bookings under trucks
  resources :trucks, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :bookings, only: [:new] # Allows bookings creation and listing under a specific truck
    # Add the cancel route for trucks here
    member do
      delete 'cancel', to: 'trucks#cancel' # Custom cancel action for truck deletion
    end
  end

  # Standalone bookings resource for user-specific actions
  resources :bookings, only: [:new, :create] # Allows bookings creation and listing under a specific truck
  resources :bookings, only: [:index, :show, :edit, :update, :destroy] # For managing bookings independently
end
