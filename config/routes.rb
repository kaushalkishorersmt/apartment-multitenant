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


  root to: "home#index"
  resources :registration

  resources :main_products
  devise_for :site_admins

  # For the Shopknekt
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
    end

    # get ':slug', to: 'pages#show', as: "pages"
  end

end
