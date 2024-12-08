class Color < ApplicationRecord
  has_and_belongs_to_many :products
  validates :name, presence: { message: "El nombre es obligatorio" },
                 uniqueness: { case_sensitive: false, message: "El nombre debe ser único" }


  validates :code, presence: true, uniqueness: { case_sensitive: false, message: "El codigo debe ser único" }, format: { with: /\A#(?:[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\z/, message: "Debe ser un código de color hexadecimal válido (ej. #RRGGBB o #RRGGBBAA)" }
end
