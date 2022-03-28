class SwithAssociationBetweenParcelAndTrainBooking < ActiveRecord::Migration[6.1]
  def change
    remove_reference :train_bookings, :parcel, index: true
    add_reference :parcels, :train_booking, index: true
  end
end
