class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.integer :news_sub_category_id
      t.string :title
      t.string :content
      t.integer :views

      t.timestamps
    end
  end
end
