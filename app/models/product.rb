class Product < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :categories
  has_many :size_stocks
  has_many :sizes, through: :size_stocks
  has_and_belongs_to_many :colors
  belongs_to :brand

  scope :active, -> { where(deactivated: false) }
  scope :deactivated, -> { where(deactivated: true) }
end
