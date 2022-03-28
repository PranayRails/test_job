class Parcel < ApplicationRecord
	belongs_to :parcel_owner
	enum status: {booked: 'Booked', shipped: 'Shipped', delivered: 'Delivered' }, _default: 'Booked'
end
