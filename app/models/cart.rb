class Cart < ApplicationRecord
  has_many :orders
  has_many :products, through: :orders

  def complete_purchase(params)
    ActiveRecord::Base.transaction do
      # Verificar si hay stock suficiente para cada orden
      orders.each do |order|
        size_stock = SizeStock.find_by(product: order.product, size: order.size)

        if size_stock.nil? || size_stock.stock_available < order.quantity
          # Si no hay stock suficiente, lanzar una excepción personalizada
          raise ActiveRecord::Rollback, "No hay stock suficiente para el producto #{order.product.name} con talle #{order.size.size}"
        else
          # Descontar el stock
          size_stock.update!(stock_available: size_stock.stock_available - order.quantity)
        end
      end
      true  # Si todo va bien, la compra se completa
    rescue ActiveRecord::Rollback => e
      # Regresar el mensaje de error específico al controlador
      Rails.logger.error "Error en la compra: #{e.message}"
      return e.message
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Error de validación: #{e.message}"
      return e.message
    end
  end

  def total
    orders.to_a.sum { |order| order.total }
  end
end
