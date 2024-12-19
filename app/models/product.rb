class Product < ApplicationRecord
  include AlgoliaSearch
  algoliasearch do
    attribute :name, :description, :unit_price
  end

  has_many :orders
  has_many :carts, through: :orders

  has_many_attached :images
  has_and_belongs_to_many :categories
  has_many :size_stocks, dependent: :destroy
  has_many :sizes, through: :size_stocks
  has_and_belongs_to_many :colors
  belongs_to :brand

  scope :active, -> { where(deactivated: false) }
  scope :deactivated, -> { where(deactivated: true) }

  validates :name, presence: { message: "El nombre es obligatorio" }, uniqueness: { case_sensitive: false, message: "El nombre debe ser único" }
  validates :unit_price, presence: { message: "El precio es obligatorio" }

  validate :validate_only_one_category_with_sizes

  after_create :create_size_stocks

  def stock_total
    self.size_stocks.sum { |size_stock| size_stock.stock_available }
  end

  private

  def validate_only_one_category_with_sizes
    categories_with_sizes = categories.select { |category| category.has_sizes? }
    puts categories_with_sizes
    if categories_with_sizes.count != 1
      errors.add(:categories, message: "Debe haber exactamente una categoría con talles asociados.")
    end
  end

  def create_size_stocks
    category = categories.with_sizes.first

    if category
      category.sizes.each do |size|
        size_stocks.create(size: size, stock_available: 0)
      end
    else
      errors.add(:base, "No se encontró una categoría con talles asociados.")
      raise ActiveRecord::RecordInvalid, self
    end
  end
end
