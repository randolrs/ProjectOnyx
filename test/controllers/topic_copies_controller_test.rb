require 'test_helper'

class TopicCopiesControllerTest < ActionController::TestCase
  setup do
    @topic_copy = topic_copies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_copies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_copy" do
    assert_difference('TopicCopy.count') do
      post :create, topic_copy: { headline_1: @topic_copy.headline_1, headline_2: @topic_copy.headline_2, headline_3: @topic_copy.headline_3, topic_id: @topic_copy.topic_id }
    end

    assert_redirected_to topic_copy_path(assigns(:topic_copy))
  end

  test "should show topic_copy" do
    get :show, id: @topic_copy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_copy
    assert_response :success
  end

  test "should update topic_copy" do
    patch :update, id: @topic_copy, topic_copy: { headline_1: @topic_copy.headline_1, headline_2: @topic_copy.headline_2, headline_3: @topic_copy.headline_3, topic_id: @topic_copy.topic_id }
    assert_redirected_to topic_copy_path(assigns(:topic_copy))
  end

  test "should destroy topic_copy" do
    assert_difference('TopicCopy.count', -1) do
      delete :destroy, id: @topic_copy
    end

    assert_redirected_to topic_copies_path
  end
end
