class CreateFans < ActiveRecord::Migration
  def change
    create_table :fans do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.text :address
      t.string :city
      t.integer :country_id
      t.string :fav_genre
      t.boolean :agree_to_privacy
      t.boolean :subscription
      t.references :user, index: true

      t.timestamps
    end
  end
end
