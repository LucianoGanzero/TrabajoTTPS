class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :size_stocks
  has_many :sizes, through: :size_stocks
  has_and_belongs_to_many :colors
  belongs_to :brand
end
