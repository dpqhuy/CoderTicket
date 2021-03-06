class CreateTicketItems < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_items do |t|
      t.references :ticket_type, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
