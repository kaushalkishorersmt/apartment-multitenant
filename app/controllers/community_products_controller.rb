class CommunityProductsController < ApplicationController
  before_action :set_community_product, only: [:show, :edit, :update, :destroy]

  # GET /community_products
  # GET /community_products.json
  def index
    @community_products = CommunityProduct.all
  end

  # GET /community_products/1
  # GET /community_products/1.json
  def show
  end

  # GET /community_products/new
  def new
    @community_product = CommunityProduct.new
  end

  # GET /community_products/1/edit
  def edit
  end

  # POST /community_products
  # POST /community_products.json
  def create
    @community_product = CommunityProduct.new(community_product_params)

    respond_to do |format|
      if @community_product.save
        format.html { redirect_to @community_product, notice: 'Community product was successfully created.' }
        format.json { render :show, status: :created, location: @community_product }
      else
        format.html { render :new }
        format.json { render json: @community_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /community_products/1
  # PATCH/PUT /community_products/1.json
  def update
    respond_to do |format|
      if @community_product.update(community_product_params)
        format.html { redirect_to @community_product, notice: 'Community product was successfully updated.' }
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
      format.html { redirect_to community_products_url, notice: 'Community product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community_product
      @community_product = CommunityProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_product_params
      params.require(:community_product).permit(:title, :decrption, :min_price, :reseller_price, :price, :tax_rate, :is_tax_inclusive, :is_featured, :is_private, :is_community_product, :subcategory_id, :image, :product_segment_id, :category_id, :quantity, :source, :source_product_id, , {community_product_properties_attributes: [:id, :quantity, :size, :color]})
    end
end
