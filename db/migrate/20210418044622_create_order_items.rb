class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true,  null: false
      t.references :item, foreign_key: true,  null: false
      t.integer :price
      t.integer :amount
      t.boolean :makeing_status,       default: 0
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end
end
