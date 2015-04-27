class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :user, index: true
      t.string :profile_image
      t.string :cover_image

      t.timestamps
    end
  end
end
