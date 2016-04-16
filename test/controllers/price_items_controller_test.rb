require 'test_helper'

class PriceItemsControllerTest < ActionController::TestCase
  setup do
    @price_item = price_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:price_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create price_item" do
    assert_difference('PriceItem.count') do
      post :create, price_item: { category: @price_item.category, country: @price_item.country, strike_date: @price_item.strike_date, strike_description: @price_item.strike_description, type: @price_item.type, value: @price_item.value }
    end

    assert_redirected_to price_item_path(assigns(:price_item))
  end

  test "should show price_item" do
    get :show, id: @price_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @price_item
    assert_response :success
  end

  test "should update price_item" do
    patch :update, id: @price_item, price_item: { category: @price_item.category, country: @price_item.country, strike_date: @price_item.strike_date, strike_description: @price_item.strike_description, type: @price_item.type, value: @price_item.value }
    assert_redirected_to price_item_path(assigns(:price_item))
  end

  test "should destroy price_item" do
    assert_difference('PriceItem.count', -1) do
      delete :destroy, id: @price_item
    end

    assert_redirected_to price_items_path
  end
end
