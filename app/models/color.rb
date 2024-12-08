class Color < ApplicationRecord
  has_and_belongs_to_many :products

  validates :code, presence: true, format: { with: /\A#(?:[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\z/, message: "Debe ser un código de color hexadecimal válido (ej. #RRGGBB o #RRGGBBAA)" }
end
