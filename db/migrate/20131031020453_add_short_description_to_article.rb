class AddShortDescriptionToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :short_description, :text
  end
end
