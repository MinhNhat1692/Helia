class CreateNewsSubCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :news_sub_categories do |t|
      t.string :name
      t.integer :news_category_id

      t.timestamps
    end
  end
end
