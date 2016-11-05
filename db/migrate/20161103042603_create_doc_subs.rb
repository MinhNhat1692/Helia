class CreateDocSubs < ActiveRecord::Migration[5.0]
  def change
    create_table :doc_subs do |t|
      t.references :doc_cats, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
