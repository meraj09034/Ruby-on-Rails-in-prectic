class RemoveDetailesToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :price, :decimal, precision: 5, scale: 2
    remove_reference :products, :supplier, polymorphic: true, index: true
  end
end
