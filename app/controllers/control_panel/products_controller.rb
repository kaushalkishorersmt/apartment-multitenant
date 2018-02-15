class ControlPanel::ProductsController < ApplicationController
  before_action :authenticate_site_admin!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # wrap_parameters include: Product.attribute_names + [:product_segment_id]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @product_segments = ProductSegment.all
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save

        if @product.is_private == false
          @community_product = CommunityProduct.create!(title: @product.title, decrption: @product.decrption, min_price: @product.min_price, reseller_price: @product.reseller_price, price: @product.price, tax_rate: @product.tax_rate, is_tax_inclusive: @product.is_tax_inclusive, is_featured: @product.is_featured, is_private: @product.is_private, is_community_product: @product.is_community_product, subcategory_id: @product.subcategory_id, image: @product.image, source: Apartment::Tenant.current, source_product_id: @product.id )

          @product.product_properties.each do |product_property|
            @community_product.community_product_properties.create!(quantity: product_property.quantity, size: product_property.size, color: product_property.color)
          end
        end

        format.html { redirect_to control_panel_products_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        # byebug
        if @product.is_private == false
           CommunityProduct.update_all(title: @product.title, decrption: @product.decrption, min_price: @product.min_price, reseller_price: @product.reseller_price, price: @product.price, tax_rate: @product.tax_rate, is_tax_inclusive: @product.is_tax_inclusive, is_featured: @product.is_featured, is_private: @product.is_private, is_community_product: @product.is_community_product, subcategory_id: @product.subcategory_id, image: @product.image, source: Apartment::Tenant.current, source_product_id: @product.id )

           @community_product = CommunityProduct.find_by(source: Apartment::Tenant.current, source_product_id: @product.id)

          @product.product_properties.each do |product_property|
            @community_product.community_product_properties.update_all(quantity: product_property.quantity, size: product_property.size, color: product_property.color)
          end
        end

        format.html { redirect_to control_panel_products_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|

      if @product.is_private == false
        @community_product = CommunityProduct.find_by(source: Apartment::Tenant.current, source_product_id: @product.id)
        if @community_product.present?
          @community_product.destroy
        end
      end

      format.html { redirect_to control_panel_products_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :decrption, :min_price, :reseller_price, :price, :tax_rate, :is_tax_inclusive, :is_featured, :is_private, :is_community_product, :subcategory_id, :image, :product_segment_id, :category_id, :quantity, {product_properties_attributes: [:id, :quantity, :size, :color]})
    end
end
