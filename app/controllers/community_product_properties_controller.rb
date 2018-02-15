class CommunityProductPropertiesController < ApplicationController
  before_action :set_community_product_property, only: [:show, :edit, :update, :destroy]

  # GET /community_product_properties
  # GET /community_product_properties.json
  def index
    @community_product_properties = CommunityProductProperty.all
  end

  # GET /community_product_properties/1
  # GET /community_product_properties/1.json
  def show
  end

  # GET /community_product_properties/new
  def new
    @community_product_property = CommunityProductProperty.new
  end

  # GET /community_product_properties/1/edit
  def edit
  end

  # POST /community_product_properties
  # POST /community_product_properties.json
  def create
    @community_product_property = CommunityProductProperty.new(community_product_property_params)

    respond_to do |format|
      if @community_product_property.save
        format.html { redirect_to @community_product_property, notice: 'Community product property was successfully created.' }
        format.json { render :show, status: :created, location: @community_product_property }
      else
        format.html { render :new }
        format.json { render json: @community_product_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /community_product_properties/1
  # PATCH/PUT /community_product_properties/1.json
  def update
    respond_to do |format|
      if @community_product_property.update(community_product_property_params)
        format.html { redirect_to @community_product_property, notice: 'Community product property was successfully updated.' }
        format.json { render :show, status: :ok, location: @community_product_property }
      else
        format.html { render :edit }
        format.json { render json: @community_product_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /community_product_properties/1
  # DELETE /community_product_properties/1.json
  def destroy
    @community_product_property.destroy
    respond_to do |format|
      format.html { redirect_to community_product_properties_url, notice: 'Community product property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community_product_property
      @community_product_property = CommunityProductProperty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_product_property_params
      params.require(:community_product_property).permit(:community_product_id, :size, :color, :quantity)
    end
end
