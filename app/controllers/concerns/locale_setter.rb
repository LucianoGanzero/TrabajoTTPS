module LocaleSetter
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  private

  def set_locale
    lang = params[:lang]
    # Verifica si el locale es válido (en o es)
    if lang && I18n.available_locales.include?(lang.to_sym)
      I18n.locale = lang.to_sym
    else
      I18n.locale = I18n.default_locale # Establece el locale por defecto si no es válido
    end
  end
end
