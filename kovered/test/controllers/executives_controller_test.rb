require 'test_helper'

class ExecutivesControllerTest < ActionController::TestCase
  setup do
    @executive = executives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:executives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create executive" do
    assert_difference('Executive.count') do
      post :create, executive: { address: @executive.address, agree_to_privacy: @executive.agree_to_privacy, city: @executive.city, country_id: @executive.country_id, date_of_birth: @executive.date_of_birth, first_name: @executive.first_name, gender: @executive.gender, last_name: @executive.last_name, subscription: @executive.subscription, user_id: @executive.user_id, website: @executive.website }
    end

    assert_redirected_to executive_path(assigns(:executive))
  end

  test "should show executive" do
    get :show, id: @executive
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @executive
    assert_response :success
  end

  test "should update executive" do
    patch :update, id: @executive, executive: { address: @executive.address, agree_to_privacy: @executive.agree_to_privacy, city: @executive.city, country_id: @executive.country_id, date_of_birth: @executive.date_of_birth, first_name: @executive.first_name, gender: @executive.gender, last_name: @executive.last_name, subscription: @executive.subscription, user_id: @executive.user_id, website: @executive.website }
    assert_redirected_to executive_path(assigns(:executive))
  end

  test "should destroy executive" do
    assert_difference('Executive.count', -1) do
      delete :destroy, id: @executive
    end

    assert_redirected_to executives_path
  end
end
