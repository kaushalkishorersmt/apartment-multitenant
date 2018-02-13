class ControlPanel::ProductSegmentsController < ApplicationController
  before_action :authenticate_site_admin!
  before_action :set_product_segment, only: [:show, :edit, :update, :destroy]

  # GET /product_segments
  # GET /product_segments.json
  def index
    @product_segments = ProductSegment.all
  end

  # GET /product_segments/1
  # GET /product_segments/1.json
  def show
  end

  # GET /product_segments/new
  def new
    @product_segment = ProductSegment.new
  end

  # GET /product_segments/1/edit
  def edit
  end

  # POST /product_segments
  # POST /product_segments.json
  def create
    @product_segment = ProductSegment.new(product_segment_params)

    respond_to do |format|
      if @product_segment.save
        format.html { redirect_to control_panel_product_segments_path, notice: 'Product segment was successfully created.' }
        format.json { render :show, status: :created, location: @product_segment }
      else
        format.html { render :new }
        format.json { render json: @product_segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_segments/1
  # PATCH/PUT /product_segments/1.json
  def update
    respond_to do |format|
      if @product_segment.update(product_segment_params)
        format.html { redirect_to control_panel_product_segments_path, notice: 'Product segment was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_segment }
      else
        format.html { render :edit }
        format.json { render json: @product_segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_segments/1
  # DELETE /product_segments/1.json
  def destroy
    @product_segment.destroy
    respond_to do |format|
      format.html { redirect_to control_panel_product_segments_path, notice: 'Product segment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_segment
      @product_segment = ProductSegment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_segment_params
      params.require(:product_segment).permit(:title)
    end
end
