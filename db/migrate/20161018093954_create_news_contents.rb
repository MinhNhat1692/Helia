class CreateNewsContents < ActiveRecord::Migration[5.0]
  def change
    create_table :news_contents do |t|
      t.references :news_header, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
