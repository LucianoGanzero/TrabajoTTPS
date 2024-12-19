class Category < ApplicationRecord
  has_and_belongs_to_many :products
  has_and_belongs_to_many :sizes

  validates :name, presence: { message: "El nombre es obligatorio" },
                 uniqueness: { case_sensitive: false, message: "El nombre debe ser único" }


  scope :with_sizes, -> { joins(:sizes).distinct }

  scope :without_sizes, -> { left_joins(:sizes).where(sizes: { id: nil }) }

  def has_sizes?
    sizes.any?
  end

  def update_sizes_and_products(previous_sizes)
    current_sizes = self.sizes.to_a

    # Detectar los talles agregados
    added_sizes = current_sizes - previous_sizes
    added_sizes.each do |size|
      self.products.each do |product|
        # Crear un size_stock con stock_available igual a 0 para los talles nuevos de los productos asociados
        SizeStock.create(product: product, size: size, stock_available: 0)
      end
    end

    # Detectar los talles eliminados
    removed_sizes = previous_sizes - current_sizes
    removed_sizes.each do |size|
      self.products.each do |product|
        # Eliminar el size_stock para el talle eliminado
        SizeStock.where(product: product, size: size).destroy_all
      end
    end
  end
end
