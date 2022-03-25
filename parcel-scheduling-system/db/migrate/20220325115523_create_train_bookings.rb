class CreateTrainBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :train_bookings do |t|
      t.datetime :departure_time
      t.datetime :arrival_time

      t.timestamps
    end
  end
end
