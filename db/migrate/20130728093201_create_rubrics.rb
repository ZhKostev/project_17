class CreateRubrics < ActiveRecord::Migration
  def change
    create_table :rubrics do |t|
      t.string :title
      t.string :language
      t.integer :translation_id

      t.timestamps
    end
  end
end
