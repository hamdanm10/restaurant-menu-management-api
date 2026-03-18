class CreateMenuItems < ActiveRecord::Migration[8.1]
  def change
    create_table :menu_items do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :category, null: false
      t.boolean :is_available, null: false, default: true

      t.timestamps
    end

    add_index :menu_items, :name
    add_index :menu_items, :category
    add_index :menu_items, [ :category, :is_available ]
  end
end
