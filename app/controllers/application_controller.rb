class ApplicationController < ActionController::Base
  include Authentication
  include LocaleSetter
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # include Authenticated
  allow_browser versions: :modern
  before_action :set_render_cart
  before_action :initialize_cart

  def not_found 
    render template: 'errors/not_found', status: 404 
  end

  def set_render_cart
    @render_cart = true
  end
  def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
