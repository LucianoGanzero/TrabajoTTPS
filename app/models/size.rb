class Size < ApplicationRecord
  has_and_belongs_to_many :categories

  # Scope para talles numéricos
  scope :numeric_sizes, -> { all.select { |size| size.size =~ /\d/ }.sort_by(&:size) }

  scope :letter_sizes, -> {
  all.select { |size| size.size !~ /\d/ }.sort_by { |size| size_sort_key(size.size) }
}

  def self.size_sort_key(size)
    match = size.match(/^(X*)([SML])$/)
    return Float::INFINITY unless match

    prefix, base = match.captures
    base_order = { "S" => 0, "M" => 1, "L" => 2 }[base]
    x_modifier = base == "S" ? -1 : 1

    base_order * 100 + x_modifier * prefix.length
  end
end
