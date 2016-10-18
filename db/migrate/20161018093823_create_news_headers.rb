class CreateNewsHeaders < ActiveRecord::Migration[5.0]
  def change
    create_table :news_headers do |t|
      t.integer :cat
      t.string :image_f
      t.text :title
      t.text :des
      t.integer :view
      t.boolean :recomend

      t.timestamps
    end
  end
end
