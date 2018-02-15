class ControlPanel::CommunityProductsController < ApplicationController
  before_action :authenticate_site_admin!
  before_action :set_community_product, only: [:show, :edit, :update, :destroy]
  before_action :create_community_product, only: [:create]
  # GET /community_products
  # GET /community_products.json
  def index
    @community_products = CommunityProduct.where.not(id: Product.all.pluck(:community_product_id), source: Apartment::Tenant.current)
  end

  # GET /community_products/1
  # GET /community_products/1.json
  def show
  end

  # GET /community_products/new
  def new

  end

  # GET /community_products/1/edit
  def edit
  end

  # POST /community_products
  # POST /community_products.json
  def create
    @community_product = Product.new(title: @community_product.title, decrption: @community_product.decrption, min_price: @community_product.min_price, reseller_price: @community_product.reseller_price, price: @community_product.price, tax_rate: @community_product.tax_rate, is_tax_inclusive: @community_product.is_tax_inclusive, is_featured: @community_product.is_featured, is_private: @community_product.is_private, is_community_product: @community_product.is_community_product, subcategory_id: @community_product.subcategory_id, image: @community_product.image, community_product_id: @community_product.id )

    if @community_product.save
      redirect_to control_panel_community_products_path, notice: 'Community product was successfully created.'
    else
       redirect_to control_panel_community_products_path, notice: 'Error.'
    end
  end

  # PATCH/PUT /community_products/1
  # PATCH/PUT /community_products/1.json
  def update
    respond_to do |format|
      if @community_product.update(community_product_params)
        format.html { redirect_to control_panel_community_products_path, notice: 'Community product was successfully updated.' }
        format.json { render :show, status: :ok, location: @community_product }
      else
        format.html { render :edit }
        format.json { render json: @community_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /community_products/1
  # DELETE /community_products/1.json
  def destroy
    @community_product.destroy
    respond_to do |format|
      format.html { redirect_to control_panel_community_products_path, notice: 'Community product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community_product
      @community_product = CommunityProduct.find(params[:id])
    end

    def create_community_product
      @community_product = CommunityProduct.find(params[:format].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_product_params
      params.require(:product).permit(:title, :decrption, :min_price, :reseller_price, :price, :tax_rate, :is_tax_inclusive, :is_featured, :is_private, :is_community_product, :subcategory_id, :image, :product_segment_id, :category_id, :quantity, :community_product_id)
    end
end
