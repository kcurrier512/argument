require 'test_helper'

class PairMembershipsControllerTest < ActionController::TestCase
  setup do
    @pair_membership = pair_memberships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pair_memberships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pair_membership" do
    assert_difference('PairMembership.count') do
      post :create, pair_membership: {  }
    end

    assert_redirected_to pair_membership_path(assigns(:pair_membership))
  end

  test "should show pair_membership" do
    get :show, id: @pair_membership
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pair_membership
    assert_response :success
  end

  test "should update pair_membership" do
    patch :update, id: @pair_membership, pair_membership: {  }
    assert_redirected_to pair_membership_path(assigns(:pair_membership))
  end

  test "should destroy pair_membership" do
    assert_difference('PairMembership.count', -1) do
      delete :destroy, id: @pair_membership
    end

    assert_redirected_to pair_memberships_path
  end
end
