class ColorsController < ApplicationController
  before_action :set_color, only: %i[ show edit update destroy ]
  before_action :set_render_cart
  skip_before_action :initialize_cart

  # GET /colors/1 or /colors/1.json
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new
  end

  # GET /colors/1/edit
  def edit
  end

  # POST /colors or /colors.json
  def create
    @color = Color.new(color_params)

    respond_to do |format|
      if @color.save
        format.html { redirect_to store_management_path, notice: I18n.t('colors.messages.success') }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colors/1 or /colors/1.json
  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to store_management_path, notice: I18n.t('colors.messages.edit_success') }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1 or /colors/1.json
  def destroy
    @color.destroy!

    respond_to do |format|
      format.html { redirect_to store_management_path, status: :see_other, notice: I18n.t('colors.messages.destroy_success') }
      format.json { head :no_content }
    end
  end

  def disassociate
    product = Product.find(params[:product_id])
    color = Color.find(params[:id])

    if product.colors.delete(color)
      redirect_to product_path(product), notice: I18n.t('colors.messages.dissasociate_succes', color_name: @color.name)
    else
      redirect_to product_path(product), alert: I18n.t('colors.messages.dissasociate_fail', color_name: @color.name)
    end
  end

  private
    def set_render_cart
      @render_cart = false
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def color_params
      params.expect(color: [ :name, :code ])
    end
end
