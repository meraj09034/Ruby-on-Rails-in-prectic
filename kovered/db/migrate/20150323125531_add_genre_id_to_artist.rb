class AddGenreIdToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :genre_id, :int
  end
end
