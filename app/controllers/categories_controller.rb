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
        format.html { redirect_to store_management_path, notice: "La categoria se creó correctamente" }
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

      # Actualizamos la categoría con los parámetros
      if @category.update(category_params)
        # Obtenemos los talles actuales después de la actualización
        current_sizes = @category.sizes.to_a

        # Detectar los talles agregados
        added_sizes = current_sizes - previous_sizes
        added_sizes.each do |size|
          @category.products.each do |product|
            # Crear un size_stock con stock_available igual a 0 para los productos
            SizeStock.create(product: product, size: size, stock_available: 0)
          end
        end

        # Detectar los talles eliminados
        removed_sizes = previous_sizes - current_sizes
        removed_sizes.each do |size|
          @category.products.each do |product|
            # Eliminar el size_stock para el talle eliminado
            SizeStock.where(product: product, size: size).destroy_all
          end
        end
        @category.size_ids = params[:category][:size_ids]

        @category.save
        format.html { redirect_to store_management_path, notice: "La categoria se actualizó correctamente" }
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
      format.html { redirect_to store_management_path, status: :see_other, notice: "La categoria se eliminó con exito" }
      format.json { head :no_content }
    end
  end

  def disassociate
    product = Product.find(params[:product_id])
    category = Category.find(params[:id])

    if product.categories.delete(category)
      redirect_to product_path(product), notice: "La etiqueta '#{category.name}' se desasoció del producto."
    else
      redirect_to product_path(product), alert: "No se pudo desasociar la etiqueta '#{category.name}' del producto."
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
