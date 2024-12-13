class ProductSoldsController < ApplicationController
  # before_action :set_product_sold, only: %i[ show edit update destroy ]
  before_action :set_render_cart
  skip_before_action :initialize_cart


  # GET /product_solds or /product_solds.json
  # def index
  #   @product_solds = ProductSold.all
  # end

  # GET /product_solds/1 or /product_solds/1.json
  # def show
  # end

  # GET /product_solds/new
  def new
    @sale = Sale.find(params[:sale_id])
    @product_sold = ProductSold.new
  end

  # GET /product_solds/1/edit
  # def edit
  # end

  # POST /product_solds or /product_solds.json
  def create
    @sale = Sale.find(params[:sale_id])

    begin
      product = Product.find(product_sold_params[:product_id])
      size = Size.find(product_sold_params[:size_id])
      quantity = product_sold_params[:quantity].to_i

      # Verificar si hay suficiente stock
      size_stock = SizeStock.find_by(product: product, size: size)

      if size_stock && size_stock.stock_available >= quantity
        # Crear ProductSold y actualizar el stock
        ProductSold.create!(
          sale: @sale,
          product: product,
          size: size,
          quantity: quantity,
          sell_price: product.unit_price
        )

        # Actualizar el stock disponible
        size_stock.update!(stock_available: size_stock.stock_available - quantity)

        # Actualizar el total_price de la venta
        @sale.update_total_price

        respond_to do |format|
          format.html { redirect_to new_sale_product_sold_path(@sale), notice:  I18n.t('product_solds.messages.success')}
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace(
                "product-solds-table",
                partial: "product_solds_table",
                locals: { product_solds: @sale.products_solds }
              )
            ]
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_sale_product_sold_path(@sale), alert:  I18n.t('product_solds.messages.insufficient_stock')}
          format.turbo_stream { render turbo_stream: turbo_stream.append(:flash, partial: "layouts/flash", locals: { alert: I18n.t('product_solds.messages.insufficient_stock') }) }
        end
      end
    rescue => e
      logger.debug "Error al agregar el producto a la venta: #{e.message}"
      @product_sold = ProductSold.new
      render :new
    end
  end

  # PATCH/PUT /product_solds/1 or /product_solds/1.json
  # def update
  #   respond_to do |format|
  #     if @product_sold.update(product_sold_params)
  #       format.html { redirect_to @product_sold, notice: "Product sold was successfully updated." }
  #       format.json { render :show, status: :ok, location: @product_sold }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @product_sold.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /product_solds/1 or /product_solds/1.json
  # def destroy
  #   @product_sold.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to product_solds_path, status: :see_other, notice: "Product sold was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_render_cart
      @render_cart = false
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product_sold
      @product_sold = ProductSold.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_sold_params
      params.expect(product_sold: [ :sell_price, :quantity, :size_id, :product_id ])
    end
end
