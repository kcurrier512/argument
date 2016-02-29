require 'test_helper'

class FootnotesControllerTest < ActionController::TestCase
  setup do
    @footnote = footnotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:footnotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create footnote" do
    assert_difference('Footnote.count') do
      post :create, footnote: {  }
    end

    assert_redirected_to footnote_path(assigns(:footnote))
  end

  test "should show footnote" do
    get :show, id: @footnote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @footnote
    assert_response :success
  end

  test "should update footnote" do
    patch :update, id: @footnote, footnote: {  }
    assert_redirected_to footnote_path(assigns(:footnote))
  end

  test "should destroy footnote" do
    assert_difference('Footnote.count', -1) do
      delete :destroy, id: @footnote
    end

    assert_redirected_to footnotes_path
  end
end
