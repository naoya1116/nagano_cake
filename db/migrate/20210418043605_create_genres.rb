class CreateGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :genres do |t|
      t.string :name
      t.timestamp :created_at
      t.timestamp :updated_at
      t.boolean :is_enabled, default: true, null: false
      t.timestamps
    end
  end
end
