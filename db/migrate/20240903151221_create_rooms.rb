class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :address, null: false
      t.integer :capacity_max, null: false
      t.boolean :pets, default: false
      t.boolean :wifi, default: false
      t.boolean :parking, default: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_foreign_key :rooms, :users, column: :user_id
  end
end
