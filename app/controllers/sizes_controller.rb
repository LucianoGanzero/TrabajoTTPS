class SizesController < ApplicationController
  before_action :set_size, only: %i[ show edit update destroy ]
  before_action :set_render_cart
  skip_before_action :initialize_cart

  # GET /sizes/1 or /sizes/1.json
  def show
  end

  # GET /sizes/new
  def new
    @size = Size.new
  end

  # GET /sizes/1/edit
  def edit
  end

  # POST /sizes or /sizes.json
  def create
    @size = Size.new(size_params)

    respond_to do |format|
      if @size.save
        format.html { redirect_to store_management_path, notice: I18n.t("sizes.messages.success") }
        format.json { render :show, status: :created, location: @size }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sizes/1 or /sizes/1.json
  def update
    respond_to do |format|
      if @size.update(size_params)
        format.html { redirect_to store_management_path, notice: I18n.t("sizes.messages.update") }
        format.json { render :show, status: :ok, location: @size }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sizes/1 or /sizes/1.json
  def destroy
    @size.destroy!

    respond_to do |format|
      format.html { redirect_to store_management_path, status: :see_other, notice: I18n.t("sizes.messages.destroy") }
      format.json { head :no_content }
    end
  end

  private
    def set_render_cart
      @render_cart = false
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_size
      @size = Size.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def size_params
      params.expect(size: [ :size ])
    end
end
