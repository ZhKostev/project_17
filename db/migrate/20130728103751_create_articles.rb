class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :language
      t.integer :translation_id
      t.text :meta_description
      t.boolean :published

      t.timestamps
    end
    add_index :articles, [:translation_id], :name => 'articles_translation_id_index'
    add_index :articles, [:published], :name => 'articles_published_index'
  end
end
