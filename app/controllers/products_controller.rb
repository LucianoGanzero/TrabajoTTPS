class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_render_cart

  # GET /products or /products.json
  def index
    @active_products = Product.active
    @deactivated_products = Product.deactivated
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: I18n.t("products.messages.success") }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: I18n.t("products.messages.update") }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: I18n.t("products.messages.destroy") }
      format.json { head :no_content }
    end
  end

  def deactivate
    @product = Product.find(params[:id])

    ActiveRecord::Base.transaction do
      @product.size_stocks.update_all(stock_available: 0)

      if @product.update(deactivated: true, deactivation_date: Date.today)
        redirect_to products_path, notice: I18n.t("products.messages.deactivate")
      else
        raise ActiveRecord::Rollback
      end
    end

  rescue => e
    redirect_to products_path, alert: I18n.t("products.messages.deactivate_error", message: e.message)
  end
  def activate
    @product = Product.find(params[:id])

    if @product.update(deactivated: false)
      redirect_to products_path, notice: I18n.t("products.messages.activate")
    else
      redirect_to products_path, alert: I18n.t("products.messages.activate_error")
    end
  end

  private
    def set_render_cart
      @render_cart = false
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(
        :name, :description, :unit_price, :entry_date, :deactivation_date, :brand_id,
        size_ids: [], category_ids: [], color_ids: [], images: []
      )
    end
end
