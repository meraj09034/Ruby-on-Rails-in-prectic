class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.text :address
      t.string :city
      t.integer :country_id
      t.string :band_name
      t.string :dialog
      t.boolean :agree_to_privacy
      t.boolean :subscription
      t.references :user, index: true

      t.timestamps
    end
  end
end
