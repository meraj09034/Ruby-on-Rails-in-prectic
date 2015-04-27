class CreateMusicGenres < ActiveRecord::Migration
  def change
    create_table :music_genres do |t|
      t.string :name
    end
  end
end
