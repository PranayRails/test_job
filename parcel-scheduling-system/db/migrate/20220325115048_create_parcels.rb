class CreateParcels < ActiveRecord::Migration[6.1]
  def change
    create_table :parcels do |t|
      t.decimal :weight
      t.integer :volume
      t.string :source
      t.string :destination
      t.string :status
      t.decimal :cost
      t.references :parcel_owner

      t.timestamps
    end
  end
end
