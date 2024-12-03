require "application_system_test_case"

class SizeStocksTest < ApplicationSystemTestCase
  setup do
    @size_stock = size_stocks(:one)
  end

  test "visiting the index" do
    visit size_stocks_url
    assert_selector "h1", text: "Size stocks"
  end

  test "should create size stock" do
    visit size_stocks_url
    click_on "New size stock"

    fill_in "Stock available", with: @size_stock.stock_available
    click_on "Create Size stock"

    assert_text "Size stock was successfully created"
    click_on "Back"
  end

  test "should update Size stock" do
    visit size_stock_url(@size_stock)
    click_on "Edit this size stock", match: :first

    fill_in "Stock available", with: @size_stock.stock_available
    click_on "Update Size stock"

    assert_text "Size stock was successfully updated"
    click_on "Back"
  end

  test "should destroy Size stock" do
    visit size_stock_url(@size_stock)
    click_on "Destroy this size stock", match: :first

    assert_text "Size stock was successfully destroyed"
  end
end
