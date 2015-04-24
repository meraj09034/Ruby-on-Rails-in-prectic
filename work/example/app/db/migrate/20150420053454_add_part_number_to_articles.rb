class AddPartNumberToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :part_number, :string
  end
end
