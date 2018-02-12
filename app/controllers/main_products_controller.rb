class MainProductsController < ApplicationController
  before_action :set_main_product, only: [:show, :edit, :update, :destroy]

  # GET /main_products
  # GET /main_products.json
  def index
    @main_products = MainProduct.all
  end

  # GET /main_products/1
  # GET /main_products/1.json
  def show
  end

  # GET /main_products/new
  def new
    @main_product = MainProduct.new
  end

  # GET /main_products/1/edit
  def edit
  end

  # POST /main_products
  # POST /main_products.json
  def create
    @main_product = MainProduct.new(main_product_params)

    respond_to do |format|
      if @main_product.save
        format.html { redirect_to @main_product, notice: 'Main product was successfully created.' }
        format.json { render :show, status: :created, location: @main_product }
      else
        format.html { render :new }
        format.json { render json: @main_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /main_products/1
  # PATCH/PUT /main_products/1.json
  def update
    respond_to do |format|
      if @main_product.update(main_product_params)
        format.html { redirect_to @main_product, notice: 'Main product was successfully updated.' }
        format.json { render :show, status: :ok, location: @main_product }
      else
        format.html { render :edit }
        format.json { render json: @main_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /main_products/1
  # DELETE /main_products/1.json
  def destroy
    @main_product.destroy
    respond_to do |format|
      format.html { redirect_to main_products_url, notice: 'Main product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_product
      @main_product = MainProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_product_params
      params.require(:main_product).permit(:title)
    end
end
