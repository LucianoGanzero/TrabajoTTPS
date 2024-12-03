require "test_helper"

class SizeStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @size_stock = size_stocks(:one)
  end

  test "should get index" do
    get size_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_size_stock_url
    assert_response :success
  end

  test "should create size_stock" do
    assert_difference("SizeStock.count") do
      post size_stocks_url, params: { size_stock: { stock_available: @size_stock.stock_available } }
    end

    assert_redirected_to size_stock_url(SizeStock.last)
  end

  test "should show size_stock" do
    get size_stock_url(@size_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_size_stock_url(@size_stock)
    assert_response :success
  end

  test "should update size_stock" do
    patch size_stock_url(@size_stock), params: { size_stock: { stock_available: @size_stock.stock_available } }
    assert_redirected_to size_stock_url(@size_stock)
  end

  test "should destroy size_stock" do
    assert_difference("SizeStock.count", -1) do
      delete size_stock_url(@size_stock)
    end

    assert_redirected_to size_stocks_url
  end
end
