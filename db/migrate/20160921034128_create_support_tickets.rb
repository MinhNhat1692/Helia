class CreateSupportTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :support_tickets do |t|
      t.references :user, foreign_key: true
      t.text :title
      t.text :infomation
      t.string :attachment
      t.integer :status

      t.timestamps
    end
  end
end
