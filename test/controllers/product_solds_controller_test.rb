require "test_helper"

class ProductSoldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_sold = product_solds(:one)
  end

  test "should get index" do
    get product_solds_url
    assert_response :success
  end

  test "should get new" do
    get new_product_sold_url
    assert_response :success
  end

  test "should create product_sold" do
    assert_difference("ProductSold.count") do
      post product_solds_url, params: { product_sold: { quantity: @product_sold.quantity, sell_price: @product_sold.sell_price } }
    end

    assert_redirected_to product_sold_url(ProductSold.last)
  end

  test "should show product_sold" do
    get product_sold_url(@product_sold)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_sold_url(@product_sold)
    assert_response :success
  end

  test "should update product_sold" do
    patch product_sold_url(@product_sold), params: { product_sold: { quantity: @product_sold.quantity, sell_price: @product_sold.sell_price } }
    assert_redirected_to product_sold_url(@product_sold)
  end

  test "should destroy product_sold" do
    assert_difference("ProductSold.count", -1) do
      delete product_sold_url(@product_sold)
    end

    assert_redirected_to product_solds_url
  end
end
