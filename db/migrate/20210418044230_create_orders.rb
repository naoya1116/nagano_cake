class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true,  null: false
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :shipping
      t.integer :payment_method,       default: 0
      t.boolean :status,               default: 0
      t.timestamp :created_at
      t.timestamp :updated_at
       
      t.timestamps
    end
  end
end
