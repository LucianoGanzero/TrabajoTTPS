class Product < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :categories
  has_many :size_stocks
  has_many :sizes, through: :size_stocks
  has_and_belongs_to_many :colors
  belongs_to :brand

  scope :active, -> { where(deactivated: false) }
  scope :deactivated, -> { where(deactivated: true) }

  validate :validate_only_one_category_with_sizes

  private

  def validate_only_one_category_with_sizes
    # Obtén todas las categorías seleccionadas
    categories_with_sizes = categories.select { |category| category.has_sizes? }
    puts categories_with_sizes
    # Verifica que haya exactamente una categoría con talles
    if categories_with_sizes.count != 1
      errors.add(:category_ids, "Debe haber exactamente una categoría con talles asociados.")
    end
  end
end
