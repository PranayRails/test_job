class Parcel < ApplicationRecord
  validates_presence_of :weight, :volume, :source, :destination, :status, :cost
	belongs_to :parcel_owner
	belongs_to :train_booking, optional: true
	enum status: { booked: 'Booked', shipped: 'Shipped', delivered: 'Delivered' }, _default: 'Booked'
end
