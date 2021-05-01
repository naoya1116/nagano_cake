class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true,  null: false
      t.string :name
      t.string :image_id
      t.text :introduction
      t.integer :price
      t.boolean :is_active,      null: false, default: true
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end
end
