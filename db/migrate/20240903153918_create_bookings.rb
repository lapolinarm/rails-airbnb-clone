class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :date_start, null: false
      t.date :date_finish, null: false
      t.decimal :final_price, precision: 10, scale: 2
      t.integer :user_id, null: false
      t.integer :room_id, null: false

      t.timestamps
    end

    add_foreign_key :bookings, :users, column: :user_id
    add_foreign_key :bookings, :rooms, column: :room_id
  end
end
