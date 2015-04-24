class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.integer :length
      t.date :date

      t.timestamps
    end
  end
end
