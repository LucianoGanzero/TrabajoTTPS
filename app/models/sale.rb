class Sale < ApplicationRecord
  has_many :product_solds
  belongs_to :salesman, class_name: "User"
end
