class RemoveColumnsFromArtists < ActiveRecord::Migration
  def change
    remove_column :artists, :dialog, :string
    remove_column :artists, :address, :string
  end
end
