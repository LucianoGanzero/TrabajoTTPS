require "application_system_test_case"

class ProductSoldsTest < ApplicationSystemTestCase
  setup do
    @product_sold = product_solds(:one)
  end

  test "visiting the index" do
    visit product_solds_url
    assert_selector "h1", text: "Product solds"
  end

  test "should create product sold" do
    visit product_solds_url
    click_on "New product sold"

    fill_in "Quantity", with: @product_sold.quantity
    fill_in "Sell price", with: @product_sold.sell_price
    click_on "Create Product sold"

    assert_text "Product sold was successfully created"
    click_on "Back"
  end

  test "should update Product sold" do
    visit product_sold_url(@product_sold)
    click_on "Edit this product sold", match: :first

    fill_in "Quantity", with: @product_sold.quantity
    fill_in "Sell price", with: @product_sold.sell_price
    click_on "Update Product sold"

    assert_text "Product sold was successfully updated"
    click_on "Back"
  end

  test "should destroy Product sold" do
    visit product_sold_url(@product_sold)
    click_on "Destroy this product sold", match: :first

    assert_text "Product sold was successfully destroyed"
  end
end
