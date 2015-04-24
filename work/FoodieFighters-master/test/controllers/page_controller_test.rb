require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get clients" do
    get :clients
    assert_response :success
  end

  test "should get battles" do
    get :battles
    assert_response :success
  end

  test "should get store" do
    get :store
    assert_response :success
  end

end
