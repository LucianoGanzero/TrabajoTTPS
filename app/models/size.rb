class Size < ApplicationRecord
  has_and_belongs_to_many :categories

  # Ordenar los talles siglas según el criterio de tamaño
  SIZE_ORDER = [ "XXS", "XS", "S", "M", "L", "XL", "XXL" ]

  # Scope para talles numéricos
  scope :numeric_sizes, -> { all.select { |size| size.size =~ /\d/ }.sort_by(&:size) }

  # Scope para talles con siglas, ordenados por el criterio de tamaño
  scope :letter_sizes, -> {
    all.select { |size| size.size !~ /\d/ }.sort_by { |size| SIZE_ORDER.index(size.size) || SIZE_ORDER.length }
  }
end
