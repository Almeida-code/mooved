Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Nested bookings under trucks for truck-specific actions
  resources :trucks, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :bookings, only: [:new, :create]
  end

  # Standalone bookings resource for user-specific bookings management
  resources :bookings, only: [:index, :show, :edit, :update, :destroy]
end
