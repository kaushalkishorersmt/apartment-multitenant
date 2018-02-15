class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www }
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

class LandingConstraint
  def self.matches?(request)
    domains = %w{ www.lvh.me lvh.me localhost www.localhost bizknekt.com www.bizknekt.com }
    case request.subdomain
    when '', 'www'
     domains.include?(request.domain)
    else
      false
    end
  end
end

Rails.application.routes.draw do

  resources :community_product_properties
  resources :community_products

  root to: "home#index"
  get '/product/show', to: "home#show"
  resources :shop_registration

  resources :main_products
  # devise_for :site_admins
  devise_for :site_admins, controllers: {
    sessions: 'site_admins/sessions'
  }
  as :site_admin do
    get '/site_admin_login', to: 'site_admins/sessions#new', as: 'site_admin_login'
    get '/site_admin_logout', to: 'site_admins/sessions#destroy', as: 'site_admin_logout', via: Devise.mappings[:site_admin].sign_out_via
    get '/site_admin_signup', to: 'site_admins/registrations#new', as: 'site_admin_signup'
  end


  devise_for :customers, controllers: {
    sessions: 'customers/sessions'
  }
  as :customer do
    get '/customer_login', to: 'customers/sessions#new', as: 'customer_login'
    get '/customer_logout', to: 'customers/sessions#destroy', as: 'customer_logout', via: Devise.mappings[:customer].sign_out_via
    get '/customer_signup', to: 'customers/registrations#new', as: 'customer_signup'
  end

  # For the ShopknektV2
  constraints LandingConstraint do
    resources :themes
    namespace :control_panel do
      resources :shops

    end
  end

  # For Tenants sites.
  constraints SubdomainConstraint do
    namespace :control_panel do
      resources :product_segments
      resources :categories
      resources :subcategories
      resources :products
      resources :product_properties
    end
    # devise_for :customers
    # devise_for :customers, controllers: {
    #   sessions: 'customers/sessions'
    # }
    resources :orders
    resources :order_items
    resources :carts
      resources :shipping_addresses

    resource :cart, only: %i[update show destroy] do
      member do
        put :remove_item
        get :checkout_address
        get :checkout_review
        get :checkout_payment
      end
    end

    resources :customers, only: %i[new create update] do
      # devise_for :users, only: [ :new, :create, :update ]
      # as :user do
      resources :orders
    end

  end

end
