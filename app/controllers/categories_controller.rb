class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :set_render_cart
  skip_before_action :initialize_cart

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        @category.size_ids = params[:category][:size_ids]
        @category.save
        format.html { redirect_to store_management_path, notice: I18n.t("categories.messages.success") }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      # Guardamos los talles antes de la actualización
      previous_sizes = @category.sizes.to_a

      if @category.update(category_params)
        @category.update_sizes_and_products(previous_sizes)
        @category.size_ids = params[:category][:size_ids]

        @category.save
        format.html { redirect_to store_management_path, notice: I18n.t("categories.messages.edit_success") }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to store_management_path, status: :see_other, notice: I18n.t("categories.messages.destroy_success") }
      format.json { head :no_content }
    end
  end

  def disassociate
    product = Product.find(params[:product_id])
    category = Category.find(params[:id])

    if product.categories.delete(category)
      redirect_to product_path(product), notice: I18n.t("categories.messages.dissasociate_succes", category_name: @category.name)
    else
      redirect_to product_path(product), alert: I18n.t("categories.messages.dissasociate_fail", category_name: @category.name)
    end
  end

  private
    def set_render_cart
      @render_cart = false
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, size_ids: [])
    end
end
