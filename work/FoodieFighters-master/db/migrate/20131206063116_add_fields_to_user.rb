class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :avatar_name, :string
    add_column :users, :race, :string
    add_column :users, :intelligence, :decimal, precision:6, scale:2
    add_column :users, :stamina, :decimal, precision:6, scale:2
    add_column :users, :agility, :decimal, precision:6, scale:2
    add_column :users, :strength, :decimal, precision:6, scale:2
    add_column :users, :max_hit_points, :integer
    add_column :users, :current_hit_points, :integer
    add_column :users, :level, :integer
    add_column :users, :coins, :integer
    add_column :users, :battles_won, :integer
    add_column :users, :battles_lost, :integer
  end
end
