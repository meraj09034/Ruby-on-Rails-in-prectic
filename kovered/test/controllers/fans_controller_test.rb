require 'test_helper'

class FansControllerTest < ActionController::TestCase
  setup do
    @fan = fans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fan" do
    assert_difference('Fan.count') do
      post :create, fan: { address: @fan.address, agree_to_privacy: @fan.agree_to_privacy, city: @fan.city, country_id: @fan.country_id, date_of_birth: @fan.date_of_birth, fav_genre: @fan.fav_genre, first_name: @fan.first_name, gender: @fan.gender, last_name: @fan.last_name, subscription: @fan.subscription, user_id: @fan.user_id }
    end

    assert_redirected_to fan_path(assigns(:fan))
  end

  test "should show fan" do
    get :show, id: @fan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fan
    assert_response :success
  end

  test "should update fan" do
    patch :update, id: @fan, fan: { address: @fan.address, agree_to_privacy: @fan.agree_to_privacy, city: @fan.city, country_id: @fan.country_id, date_of_birth: @fan.date_of_birth, fav_genre: @fan.fav_genre, first_name: @fan.first_name, gender: @fan.gender, last_name: @fan.last_name, subscription: @fan.subscription, user_id: @fan.user_id }
    assert_redirected_to fan_path(assigns(:fan))
  end

  test "should destroy fan" do
    assert_difference('Fan.count', -1) do
      delete :destroy, id: @fan
    end

    assert_redirected_to fans_path
  end
end
