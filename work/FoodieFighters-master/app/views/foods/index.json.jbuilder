json.array!(@foods) do |food|
  json.extract! food, :id, :food_code, :display_name, :portion_default, :portion_amount, :portion_display_name, :factor, :portion_increment, :multiplier, :grains, :whole_grains, :vegetables, :orange_vegetables, :drkgreen_vegetables, :starchy_vegetables, :other_vegetables, :fruits, :milk, :meats, :soy, :drybeans_peas, :oils, :solid_fats, :added_sugars, :alcohol, :calories, :saturated_fats
  json.url food_url(food, format: :json)
end
