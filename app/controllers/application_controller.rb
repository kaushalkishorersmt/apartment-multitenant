class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  theme :theme_resolver
  helper_method :current_cart, :get_flag

  def find_or_create_cart
    session[:cart] ||= Hash.new(0)
  end

  def current_cart
    @cart ||= Cart.new(session[:cart])
  end

  def get_flag
    case session[:i18n]
    when 'fr' then 'fr'
    when 'cs' then 'cs'
    when 'ca' then 'ca'
    else 'us'
    end
  end


  def after_sign_in_path_for(resource)
    case request.subdomain
    when '', 'www'
      # byebug
      control_panel_shops_path
      # redirect_to '/'
    else
      if current_site_admin.present?
        control_panel_product_segments_path
      else
        '/'
      end
    end
  end



  def theme_resolver
    # byebug
    if Apartment::Tenant.current == "public"
      if current_site_admin.present? && (request.path.include? "control_panel")
        params[:theme] ||= "Dashboard"
      else
        params[:theme] ||= "Landing"
      end
    else
      if request.path.include? "control_panel"
        if current_site_admin.present?
          params[:theme] ||= "Dashboard"
        else
          @shop ||= Shop.find_by_subdomain(Apartment::Tenant.current)
          params[:theme] ||= @shop.theme.theme_name
        end
      else
        # After theme selection setup remove extra query "@site.theme.theme_name"
        @shop ||= Shop.find_by_subdomain(Apartment::Tenant.current)
        params[:theme] ||= @shop.theme.theme_name
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :contact_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :contact_number])
  end
end
