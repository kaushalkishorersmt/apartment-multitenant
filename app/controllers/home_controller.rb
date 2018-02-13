class HomeController < ApplicationController

  def index
    case request.subdomain
    when '', 'www'

    else
      if current_site_admin.present?

      else
        @products = Product.all
      end
    end
  end

end
