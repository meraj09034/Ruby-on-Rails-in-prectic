class RemoveFavGenreFromFans < ActiveRecord::Migration
  def change
    remove_column :fans, :fav_genre, :string
  end
end
