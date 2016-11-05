class CreateDocCons < ActiveRecord::Migration[5.0]
  def change
    create_table :doc_cons do |t|
      t.references :doc_subs, foreign_key: true
      t.string :header
      t.text :content

      t.timestamps
    end
  end
end
