class DashboardController < ApplicationController
  def index
  end

  def store_management
    @categories = Category.includes(:products).all
    @colors = Color.includes(:products).all
    @letter_sizes = Size.letter_sizes
    @number_sizes = Size.numeric_sizes
  end
end
