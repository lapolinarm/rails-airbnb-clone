class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :comment, null: false
      t.decimal :rating, precision: 5, scale: 2, null: false
      t.integer :booking_id, null: false

      t.timestamps
    end

    add_foreign_key :reviews, :bookings, column: :booking_id
  end
end
