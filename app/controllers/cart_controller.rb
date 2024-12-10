class CartController < ApplicationController
  allow_unauthenticated_access
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    @size = Size.find_by(id: params[:size])
    quantity = params[:quantity].to_i
    current_order = @cart.orders.find_by(product_id: @product.id, size_id: @size.id)
    size_stock = SizeStock.find_by(product: @product, size: @size)

    if size_stock.nil? || size_stock.stock_available < (current_order&.quantity.to_i + quantity)
      respond_to do |format|
        format.html { redirect_to request.referer || root_path, alert: "Stock insuficiente para #{quantity} unidades de #{@product.name} (#{@size.size})." }
        format.json { render json: { error: "Stock insuficiente" }, status: :unprocessable_entity }
      end
      return
    end


    if current_order && quantity >= 0
      current_order.update(quantity: current_order.quantity + quantity)
    elsif quantity > 0
      @cart.orders.create(product: @product, size: @size, quantity:)
    end

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
