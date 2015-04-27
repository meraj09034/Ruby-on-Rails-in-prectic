class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :user, index: true
      t.boolean :admin, null: false, default: false
      t.boolean :executive, null: false, default: false
      t.boolean :artist, null: false, default: false
      t.boolean :fan, null: false, default: false
      t.boolean :is_active, null: false, default: true
    end
  end
end
