Rails.application.routes.draw do
  devise_for :site_admins
  root to: "home#index"

end
