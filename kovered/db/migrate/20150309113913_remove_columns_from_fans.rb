class RemoveColumnsFromFans < ActiveRecord::Migration
  def change
    remove_column :fans, :address, :string
    remove_column :fans, :gender, :string
  end
end
