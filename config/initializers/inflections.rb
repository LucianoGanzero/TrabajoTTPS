# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, "\\1en"
#   inflect.singular /^(ox)en/i, "\\1"
#   inflect.irregular "person", "people"
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym "RESTful"
# end

ActiveSupport::Inflector.inflections(:es) do |inflect|
  # Regla para pluralizar palabras que terminan en "l"
  inflect.plural(/l$/i, "les")
  inflect.singular(/les$/i, "l")

  # Regla para pluralizar palabras que terminan en "n"
  inflect.plural(/n$/i, "nes")
  inflect.singular(/nes$/i, "n")

  # Regla para pluralizar palabras que terminan en "r"
  inflect.plural(/r$/i, "res")
  inflect.singular(/res$/i, "r")
end
