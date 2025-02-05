class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show destroy ]
  before_action :set_render_cart
  skip_before_action :initialize_cart

  # GET /sales or /sales.json
  def index
    @assigned_sales = Sale.where.not(salesman_id: nil).where(cancelled: false).order(sale_date: :desc)
    @unassigned_sales = Sale.where(salesman_id: nil).where(cancelled: false).order(sale_date: :desc)
    @cancelled_sales = Sale.where(cancelled: true).order(cancel_date: :desc)
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  # def edit
  # end

  # POST /sales or /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale.salesman = Current.user
    if @sale.save
      redirect_to new_sale_product_sold_path(@sale)
    else
      render :new
    end
  end

  # # PATCH/PUT /sales/1 or /sales/1.json
  # def update
  #   respond_to do |format|
  #     if @sale.update(sale_params)
  #       format.html { redirect_to @sale, notice: "Sale was successfully updated." }
  #       format.json { render :show, status: :ok, location: @sale }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @sale.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH /sales/assign_salesman
  def assign_salesman
    @sale = Sale.find(params[:id])
    @salesman = User.find(params[:sale][:salesman_id])
    if @sale.update(salesman: @salesman)
      redirect_to sales_path, notice: I18n.t("sales.messages.salesman")
    else
      redirect_to sales_path, alert: I18n.t("sales.messages.salesman_error")
    end
  end


  def search_products
    logger.debug "Received search query: #{params[:search]}"
    @sale = Sale.find(params[:sale_id])
    if params[:search].blank?
      render turbo_stream: turbo_stream.replace("product-results", partial: "sales/results", locals: { products: [] })
      return
    end

    @products = Product.where("name LIKE ?", "%#{params[:search]}%")
    render partial: "sales/results", locals: { products: @products, sale: @sale }
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    @sale = Sale.find(params[:id])

    # Iniciar la transacción
    ActiveRecord::Base.transaction do
      # Marcar la venta como cancelada y asignar la fecha de cancelación
      @sale.update!(cancelled: true, cancel_date: Time.current)

      # Aumentar el stock disponible de los productos vendidos
      @sale.product_solds.each do |product_sold|
        size_stock = SizeStock.find_by(product_id: product_sold.product_id, size_id: product_sold.size_id)

        if size_stock
          # Aumentar el stock disponible
          size_stock.update!(stock_available: size_stock.stock_available + product_sold.quantity)
        else
          # Si no se encuentra un SizeStock, lanzamos un error para hacer rollback
          raise ActiveRecord::Rollback, "No se encontró el stock para el producto #{product_sold.product.name}"
        end
      end


      # Si todo va bien, redirigir
      redirect_to sales_path, notice: I18n.t("sales.messages.cancel")
      rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback => e
        # Si ocurre un error, manejar el rollback
        redirect_to sales_path, alert: I18n.t("sales.messages.cancel_error", message: e.message)
      end
  end

  private
    def set_render_cart
      @render_cart = false
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.expect(sale: [ :total_price, :client, :sale_date ])
    end
end
