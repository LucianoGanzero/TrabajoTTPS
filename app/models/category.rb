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
end
