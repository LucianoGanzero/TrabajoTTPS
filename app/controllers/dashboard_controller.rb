class DashboardController < ApplicationController
  before_action :set_render_cart
  def index
  end

  def store_management
    @categories = Category.includes(:products).all
    @colors = Color.includes(:products).all
    @letter_sizes = Size.letter_sizes
    @number_sizes = Size.numeric_sizes
  end
  private
  def set_render_cart
    @render_cart = false
  end
end
