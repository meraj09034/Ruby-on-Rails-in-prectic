class AddColumnsToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :artist_id, :integer
    add_column :videos, :video, :string
  end
end
