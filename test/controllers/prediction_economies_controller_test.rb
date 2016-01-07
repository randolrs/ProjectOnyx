require 'test_helper'

class PredictionEconomiesControllerTest < ActionController::TestCase
  setup do
    @prediction_economy = prediction_economies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prediction_economies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prediction_economy" do
    assert_difference('PredictionEconomy.count') do
      post :create, prediction_economy: { country: @prediction_economy.country, strike_date: @prediction_economy.strike_date, strike_description: @prediction_economy.strike_description, type: @prediction_economy.type, type_id: @prediction_economy.type_id, value: @prediction_economy.value }
    end

    assert_redirected_to prediction_economy_path(assigns(:prediction_economy))
  end

  test "should show prediction_economy" do
    get :show, id: @prediction_economy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prediction_economy
    assert_response :success
  end

  test "should update prediction_economy" do
    patch :update, id: @prediction_economy, prediction_economy: { country: @prediction_economy.country, strike_date: @prediction_economy.strike_date, strike_description: @prediction_economy.strike_description, type: @prediction_economy.type, type_id: @prediction_economy.type_id, value: @prediction_economy.value }
    assert_redirected_to prediction_economy_path(assigns(:prediction_economy))
  end

  test "should destroy prediction_economy" do
    assert_difference('PredictionEconomy.count', -1) do
      delete :destroy, id: @prediction_economy
    end

    assert_redirected_to prediction_economies_path
  end
end
