class CreateArticlesRubricsTable < ActiveRecord::Migration
  def change
    create_table :articles_rubrics, :id => false do |t|
      t.integer :article_id
      t.integer :rubric_id
    end

    add_index :articles_rubrics, [:article_id], :name => "articles_article_id_rubrics_index"
    add_index :articles_rubrics, [:rubric_id], :name => "articles_rubric_id_rubrics_index"
  end
end
