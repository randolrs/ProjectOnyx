require 'test_helper'

class PredictionGamesControllerTest < ActionController::TestCase
  setup do
    @prediction_game = prediction_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prediction_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prediction_game" do
    assert_difference('PredictionGame.count') do
      post :create, prediction_game: { game_winner: @prediction_game.game_winner, teama_score: @prediction_game.teama_score, teamh_score: @prediction_game.teamh_score }
    end

    assert_redirected_to prediction_game_path(assigns(:prediction_game))
  end

  test "should show prediction_game" do
    get :show, id: @prediction_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prediction_game
    assert_response :success
  end

  test "should update prediction_game" do
    patch :update, id: @prediction_game, prediction_game: { game_winner: @prediction_game.game_winner, teama_score: @prediction_game.teama_score, teamh_score: @prediction_game.teamh_score }
    assert_redirected_to prediction_game_path(assigns(:prediction_game))
  end

  test "should destroy prediction_game" do
    assert_difference('PredictionGame.count', -1) do
      delete :destroy, id: @prediction_game
    end

    assert_redirected_to prediction_games_path
  end
end
