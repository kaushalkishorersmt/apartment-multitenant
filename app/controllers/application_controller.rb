class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  theme :theme_resolver




  def after_sign_in_path_for(resource)
    case request.subdomain
    when '', 'www'
      # byebug
      # redirect_to control_panel_shops_path && return
      redirect_to '/', notice: 'Shop was successfully updated.'
    else
      # control_panel_pages_path
    end
  end



  def theme_resolver
    byebug
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
          @site ||= Site.find_by_subdomain(Apartment::Tenant.current)
          params[:theme] ||= @site.theme.theme_name
        end
      else
        # After theme selection setup remove extra query "@site.theme.theme_name"
        @site ||= Site.find_by_subdomain(Apartment::Tenant.current)
        params[:theme] ||= @site.theme.theme_name
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :contact_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :contact_number])
  end
end
