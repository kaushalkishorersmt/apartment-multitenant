Rails.application.routes.draw do
  resources :main_products
  devise_for :site_admins
  root to: "home#index"

end
