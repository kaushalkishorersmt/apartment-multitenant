Rails.application.routes.draw do
  resources :registration

  resources :shops
  resources :themes
  resources :main_products
  devise_for :site_admins
  root to: "home#index"

end
