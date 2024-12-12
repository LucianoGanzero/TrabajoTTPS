class ShopProductsController < ApplicationController
  allow_unauthenticated_access
  def index
    @categories = Category.all
    @colors = Color.all
    @brands = Brand.all

    base_scope = Product.active.joins(:size_stocks).where("size_stocks.stock_available > 0").distinct

    if params[:query].present?
      algolia_ids = Product.search(params[:query]).map(&:id)
      base_scope = base_scope.where(id: algolia_ids)
    end

    if params[:category].present?
      base_scope = base_scope.joins(:categories).where(categories: { id: params[:categories].split(",") })
    end

    if params[:color].present?
      base_scope = base_scope.joins(:colors).where(colors: { id: params[:color] })
    end

    if params[:brand].present?
      base_scope = base_scope.joins(:brand).where(brand: { id: params[:brand] })
    end

    @products = base_scope.page(params[:page]).per(12)
  end

  def show
    @product = Product.active.find(params[:id])
  end
end
