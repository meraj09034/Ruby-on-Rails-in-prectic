class CreateFanGenres < ActiveRecord::Migration
  def change
    create_table :fan_genres do |t|
      t.references :fan, index: true
      t.references :genre, index: true
    end
  end
end
