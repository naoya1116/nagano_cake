class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :customer, foreign_key: true,  null: false 
      t.string :name
      t.string :postal_code
      t.string :address
      t.timestamp :created_at
      t.timestamp :updated_at
      
      t.timestamps
    end
  end
end
