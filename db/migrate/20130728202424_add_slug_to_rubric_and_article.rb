class AddSlugToRubricAndArticle < ActiveRecord::Migration
  def change
    add_column :rubrics, :slug, :string
    add_column :articles, :slug, :string
    add_index :rubrics, [:slug], :name => "rubrics_slug_index"
    add_index :articles, [:slug], :name => "articles_slug_index"
  end
end
