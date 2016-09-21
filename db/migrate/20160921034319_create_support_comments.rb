class CreateSupportComments < ActiveRecord::Migration[5.0]
  def change
    create_table :support_comments do |t|
      t.references :user, foreign_key: true
      t.integer :ticket_id
      t.text :comment
      t.string :attachment

      t.timestamps
    end
  end
end
