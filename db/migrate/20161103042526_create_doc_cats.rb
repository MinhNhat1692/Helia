class CreateDocCats < ActiveRecord::Migration[5.0]
  def change
    create_table :doc_cats do |t|
      t.string :name
      t.string :icon_link
      t.string :color

      t.timestamps
    end
  end
end
