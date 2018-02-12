class RegistrationController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def create
      @site_admin = SiteAdmin.new(full_name: params[:full_name],contact_number: params[:contact_number], email: params[:email], password: params[:password], password_confirmation: params[:password])
      @site_admin.save
      sign_in(:site_admin, @site_admin)

      @shop = Shop.new(shop_name: params[:shop_name], subdomain: params[:subdomain], theme_id: params[:theme_id], main_product_id: params[:main_product_id])
      @shop.save

      redirect_to @shop, notice: 'Shop was successfully updated.'
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:shop_name, :subdomain, :domain, :theme_id, :main_product_id, :full_name)
    end
end
