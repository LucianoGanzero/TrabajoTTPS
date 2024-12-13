class SizeStocksController < ApplicationController
  before_action :set_size_stock, only: %i[ show edit update destroy increment decrement ]

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

  # PATCH /size_stocks/:id/increment
  def increment
    if @size_stock.product.deactivated
      redirect_back fallback_location: root_path, alert: I18n.t('size_stock.messages.error') 
    else
      @size_stock.increment!(:stock_available)

      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("size_stock_#{@size_stock.id}", partial: "size_stocks/size_stock", locals: { size_stock: @size_stock })
        }
      end
    end
  end

  # PATCH /size_stocks/:id/decrement
  def decrement
    if @size_stock.product.deactivated
      redirect_back fallback_location: root_path, alert: I18n.t('size_stock.messages.error') 
    else
      if @size_stock.stock_available > 0
        if @size_stock.decrement!(:stock_available)
          respond_to do |format|
            format.turbo_stream {
              render turbo_stream: turbo_stream.update("size_stock_#{@size_stock.id}", partial: "size_stocks/size_stock", locals: { size_stock: @size_stock })          }
          end
        else
          redirect_to product_path(@size_stock.product), alert: I18n.t('size_stock.messages.problem')
        end
      else
        redirect_to product_path(@size_stock.product), alert: I18n.t('size_stock.messages.decrement') 
      end
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
