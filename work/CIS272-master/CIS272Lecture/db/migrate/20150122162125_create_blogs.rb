class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.datetime :date
      t.text :content

      t.timestamps
    end
  end
end
