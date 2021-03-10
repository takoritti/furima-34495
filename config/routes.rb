Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  resources :items
  resources :purchase_record do
    resources :shipping_information, only: [:index, :create]
  end
end
