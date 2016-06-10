require 'test_helper'

class EarningsPredictionsControllerTest < ActionController::TestCase
  setup do
    @earnings_prediction = earnings_predictions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:earnings_predictions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create earnings_prediction" do
    assert_difference('EarningsPrediction.count') do
      post :create, earnings_prediction: { company: @earnings_prediction.company, company_id: @earnings_prediction.company_id, eps_actual: @earnings_prediction.eps_actual, eps_estimate: @earnings_prediction.eps_estimate, quarter: @earnings_prediction.quarter, rating: @earnings_prediction.rating, status: @earnings_prediction.status, ticker: @earnings_prediction.ticker, year: @earnings_prediction.year }
    end

    assert_redirected_to earnings_prediction_path(assigns(:earnings_prediction))
  end

  test "should show earnings_prediction" do
    get :show, id: @earnings_prediction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @earnings_prediction
    assert_response :success
  end

  test "should update earnings_prediction" do
    patch :update, id: @earnings_prediction, earnings_prediction: { company: @earnings_prediction.company, company_id: @earnings_prediction.company_id, eps_actual: @earnings_prediction.eps_actual, eps_estimate: @earnings_prediction.eps_estimate, quarter: @earnings_prediction.quarter, rating: @earnings_prediction.rating, status: @earnings_prediction.status, ticker: @earnings_prediction.ticker, year: @earnings_prediction.year }
    assert_redirected_to earnings_prediction_path(assigns(:earnings_prediction))
  end

  test "should destroy earnings_prediction" do
    assert_difference('EarningsPrediction.count', -1) do
      delete :destroy, id: @earnings_prediction
    end

    assert_redirected_to earnings_predictions_path
  end
end
