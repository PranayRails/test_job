class CreateTrains < ActiveRecord::Migration[6.1]
  def change
    create_table :trains do |t|
      t.string :source
      t.string :destination
      t.decimal :weight_capacity
      t.integer :volume_capacity
      t.string :status
      t.decimal :cost

      t.timestamps
    end
  end
end
