class ProductSoldsController < ApplicationController
  before_action :set_product_sold, only: %i[ show edit update destroy ]

  # GET /product_solds or /product_solds.json
  def index
    @product_solds = ProductSold.all
  end

  # GET /product_solds/1 or /product_solds/1.json
  def show
  end

  # GET /product_solds/new
  def new
    @product_sold = ProductSold.new
  end

  # GET /product_solds/1/edit
  def edit
  end

  # POST /product_solds or /product_solds.json
  def create
    @product_sold = ProductSold.new(product_sold_params)

    respond_to do |format|
      if @product_sold.save
        format.html { redirect_to @product_sold, notice: "Product sold was successfully created." }
        format.json { render :show, status: :created, location: @product_sold }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_sold.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_solds/1 or /product_solds/1.json
  def update
    respond_to do |format|
      if @product_sold.update(product_sold_params)
        format.html { redirect_to @product_sold, notice: "Product sold was successfully updated." }
        format.json { render :show, status: :ok, location: @product_sold }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_sold.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_solds/1 or /product_solds/1.json
  def destroy
    @product_sold.destroy!

    respond_to do |format|
      format.html { redirect_to product_solds_path, status: :see_other, notice: "Product sold was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_sold
      @product_sold = ProductSold.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_sold_params
      params.expect(product_sold: [ :sell_price, :quantity ])
    end
end
