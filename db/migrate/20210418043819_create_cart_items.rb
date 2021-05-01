class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.references :item, foreign_key: true,  null: false
      t.references :customer, foreign_key: true,  null: false
      t.integer :amount
      t.timestamp :created_at
      t.timestamp :updated_at
      
      t.timestamps
    end
  end
end
