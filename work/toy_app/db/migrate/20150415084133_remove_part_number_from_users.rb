class RemovePartNumberFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :part_number, :string
  end
end
