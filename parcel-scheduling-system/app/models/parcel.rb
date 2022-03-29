class Parcel < ApplicationRecord
  include Validation

  validates_presence_of :weight, :volume, :source, :destination, :status, :cost
  before_validation :set_cost
	belongs_to :parcel_owner
	belongs_to :train_booking, optional: true
	enum status: { booked: 'Booked', shipped: 'Shipped', delivered: 'Delivered' }, _default: 'Booked'

	validate :validate_source_and_destination

	def self.sum_weight(parcel_ids)
		Parcel.where(id: parcel_ids).sum(:weight)
	end

	def self.sum_volume(parcel_ids)
		Parcel.where(id: parcel_ids).sum(:volume)
	end

  def set_cost
    self.cost = self.weight * 2.5
  end

end
