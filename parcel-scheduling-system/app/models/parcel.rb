class Parcel < ApplicationRecord
  validates_presence_of :weight, :volume, :source, :destination, :status, :cost
	belongs_to :parcel_owner
	belongs_to :train_booking, optional: true
	enum status: { booked: 'Booked', shipped: 'Shipped', delivered: 'Delivered' }, _default: 'Booked'

	def self.sum_weight(parcel_ids)
		Parcel.where(id: parcel_ids).sum(:weight)
	end

	def self.sum_volume(parcel_ids)
		Parcel.where(id: parcel_ids).sum(:volume)
	end
end
