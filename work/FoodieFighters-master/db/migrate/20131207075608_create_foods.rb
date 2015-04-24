class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :food_code
      t.string :display_name
      t.float :portion_default
      t.float :portion_amount
      t.string :portion_display_name
      t.float :factor
      t.float :portion_increment
      t.float :multiplier
      t.float :grains
      t.float :whole_grains
      t.float :vegetables
      t.float :orange_vegetables
      t.float :drkgreen_vegetables
      t.float :starchy_vegetables
      t.float :other_vegetables
      t.float :fruits
      t.float :milk
      t.float :meats
      t.float :soy
      t.float :drybeans_peas
      t.float :oils
      t.float :solid_fats
      t.float :added_sugars
      t.float :alcohol
      t.float :calories
      t.float :saturated_fats

      t.timestamps
    end
  end
end
