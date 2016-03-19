require 'test_helper'

class TeamAnnotationsControllerTest < ActionController::TestCase
  setup do
    @team_annotation = team_annotations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_annotations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_annotation" do
    assert_difference('TeamAnnotation.count') do
      post :create, team_annotation: {  }
    end

    assert_redirected_to team_annotation_path(assigns(:team_annotation))
  end

  test "should show team_annotation" do
    get :show, id: @team_annotation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_annotation
    assert_response :success
  end

  test "should update team_annotation" do
    patch :update, id: @team_annotation, team_annotation: {  }
    assert_redirected_to team_annotation_path(assigns(:team_annotation))
  end

  test "should destroy team_annotation" do
    assert_difference('TeamAnnotation.count', -1) do
      delete :destroy, id: @team_annotation
    end

    assert_redirected_to team_annotations_path
  end
end
