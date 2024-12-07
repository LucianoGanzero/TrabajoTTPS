class ShopProductsController < ApplicationController
  allow_unauthenticated_access
  def index
    @products = Product.active.joins(:size_stocks).where("size_stocks.stock_available > 0").distinct
  end

  def show
    @product = Product.active.find(params[:id])
  end
end
