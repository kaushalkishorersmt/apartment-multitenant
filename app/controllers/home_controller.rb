class HomeController < ApplicationController
  before_action :set_product, only: [:show]

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

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:format].to_i)
    end

end
