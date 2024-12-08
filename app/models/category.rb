class Category < ApplicationRecord
  has_and_belongs_to_many :products
  has_and_belongs_to_many :sizes

  scope :with_sizes, -> { joins(:sizes).distinct }

  scope :without_sizes, -> { left_joins(:sizes).where(sizes: { id: nil }) }

  def has_sizes?
    sizes.any?
  end
end
