class CreateExecutiveGenres < ActiveRecord::Migration
  def change
    create_table :executive_genres do |t|
      t.references :executive, index: true
      t.references :genre, index: true
    end
  end
end
