class SizeStocksController < ApplicationController
  before_action :set_size_stock, only: %i[ show edit update destroy ]

  # GET /size_stocks or /size_stocks.json
  def index
    @size_stocks = SizeStock.all
  end

  # GET /size_stocks/1 or /size_stocks/1.json
  def show
  end

  # GET /size_stocks/new
  def new
    @size_stock = SizeStock.new
  end

  # GET /size_stocks/1/edit
  def edit
  end

  # POST /size_stocks or /size_stocks.json
  def create
    @size_stock = SizeStock.new(size_stock_params)

    respond_to do |format|
      if @size_stock.save
        format.html { redirect_to @size_stock, notice: "Size stock was successfully created." }
        format.json { render :show, status: :created, location: @size_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @size_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /size_stocks/1 or /size_stocks/1.json
  def update
    respond_to do |format|
      if @size_stock.update(size_stock_params)
        format.html { redirect_to @size_stock, notice: "Size stock was successfully updated." }
        format.json { render :show, status: :ok, location: @size_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @size_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /size_stocks/1 or /size_stocks/1.json
  def destroy
    @size_stock.destroy!

    respond_to do |format|
      format.html { redirect_to size_stocks_path, status: :see_other, notice: "Size stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_size_stock
      @size_stock = SizeStock.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def size_stock_params
      params.expect(size_stock: [ :stock_available ])
    end
end
