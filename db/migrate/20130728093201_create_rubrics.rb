class CreateRubrics < ActiveRecord::Migration
  def change
    create_table :rubrics do |t|
      t.string :title
      t.string :language
      t.integer :translation_id

      t.timestamps
    end

    add_index :rubrics, [:translation_id], :name => 'rubrics_translation_id_index'
  end
end
