require 'test_helper'

class FoodsControllerTest < ActionController::TestCase
  setup do
    @food = foods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food" do
    assert_difference('Food.count') do
      post :create, food: { added_sugars: @food.added_sugars, alcohol: @food.alcohol, calories: @food.calories, display_name: @food.display_name, drkgreen_vegetables: @food.drkgreen_vegetables, drybeans_peas: @food.drybeans_peas, factor: @food.factor, food_code: @food.food_code, fruits: @food.fruits, grains: @food.grains, increment: @food.increment, meats: @food.meats, milk: @food.milk, multiplier: @food.multiplier, oils: @food.oils, orange_vegetables: @food.orange_vegetables, other_vegetables: @food.other_vegetables, portion_amount: @food.portion_amount, portion_default: @food.portion_default, portion_display_name: @food.portion_display_name, saturated_fats: @food.saturated_fats, solid_fats: @food.solid_fats, soy: @food.soy, starchy_vegetables: @food.starchy_vegetables, vegetables: @food.vegetables, whole_grains: @food.whole_grains }
    end

    assert_redirected_to food_path(assigns(:food))
  end

  test "should show food" do
    get :show, id: @food
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food
    assert_response :success
  end

  test "should update food" do
    patch :update, id: @food, food: { added_sugars: @food.added_sugars, alcohol: @food.alcohol, calories: @food.calories, display_name: @food.display_name, drkgreen_vegetables: @food.drkgreen_vegetables, drybeans_peas: @food.drybeans_peas, factor: @food.factor, food_code: @food.food_code, fruits: @food.fruits, grains: @food.grains, increment: @food.increment, meats: @food.meats, milk: @food.milk, multiplier: @food.multiplier, oils: @food.oils, orange_vegetables: @food.orange_vegetables, other_vegetables: @food.other_vegetables, portion_amount: @food.portion_amount, portion_default: @food.portion_default, portion_display_name: @food.portion_display_name, saturated_fats: @food.saturated_fats, solid_fats: @food.solid_fats, soy: @food.soy, starchy_vegetables: @food.starchy_vegetables, vegetables: @food.vegetables, whole_grains: @food.whole_grains }
    assert_redirected_to food_path(assigns(:food))
  end

  test "should destroy food" do
    assert_difference('Food.count', -1) do
      delete :destroy, id: @food
    end

    assert_redirected_to foods_path
  end
end
