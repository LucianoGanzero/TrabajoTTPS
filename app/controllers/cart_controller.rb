class CartController < ApplicationController
  allow_unauthenticated_access
  skip_before_action :initialize_cart, only: [ :confirm, :show ]

  def show
    @render_cart = false
    @cart = Cart.find(params[:id])
  end

  def confirm
    @cart = Cart.find(params[:cart_id])
    client_name = "#{params[:first_name]} #{params[:last_name]}"
    error_message = @cart.complete_purchase(params)

    if error_message != true
      redirect_to cart_path(@cart), alert: error_message
    else
      begin
        sale = Sale.create!(
          total_price: @cart.total,
          client: client_name,
          sale_date: DateTime.now
        )
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error "Error de validación en la creación de la venta: #{e.message}"
        Rails.logger.error "Errores en la venta: #{sale.errors.full_messages}" if sale
        return "Error de validación: #{e.message}"
      rescue StandardError => e
        Rails.logger.error "Error desconocido al crear la venta: #{e.message}"
        return "Error desconocido: #{e.message}"
      end

      @cart.orders.each do |order|
        ProductSold.create!(
          sale: sale,
          product: order.product,
          size: order.size,
          quantity: order.quantity,
          sell_price: order.product.unit_price
        )
      end

      @cart.orders.destroy_all
      @cart.destroy

      redirect_to root_path, notice: I18n.t("cart.messages.success")
    end
  end

  def add
    @product = Product.find_by(id: params[:id])
    @size = Size.find_by(id: params[:size])
    quantity = params[:quantity].to_i
    current_order = @cart.orders.find_by(product_id: @product.id, size_id: @size.id)
    size_stock = SizeStock.find_by(product: @product, size: @size)

    if size_stock.nil? || size_stock.stock_available < (current_order&.quantity.to_i + quantity)
      respond_to do |format|
        format.html { redirect_to request.referer || root_path, alert: I18n.t("cart.messages.insufficient_stock", quantity: quantity, product_name: @product.name, size: @size.size) }
        format.json { render json: { error: I18n.t("cart.messages.insufficient_stock", quantity: quantity, product_name: @product.name, size: @size.size) }, status: :unprocessable_entity }
      end
      return
    end


    if current_order && quantity >= 0
      current_order.update(quantity: current_order.quantity + quantity)
    elsif quantity > 0
      @cart.orders.create(product: @product, size: @size, quantity:)
    end

    flash[:notice] = I18n.t("cart.messages.add_product", product_name: @product.name)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("cart",
                              partial: "cart/cart",
                              locals: { cart: @cart }),
          turbo_stream.replace("cart_count",
                              partial: "cart/cart_count",
                              locals: { cart: @cart }),
          turbo_stream.replace(@product) ]
      end
    end
  end

  def remove
    Order.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("cart",
                              partial: "cart/cart",
                              locals: { cart: @cart }),
          turbo_stream.replace("cart_count",
                              partial: "cart/cart_count",
                              locals: { cart: @cart }) ]
      end
    end
  end
end
