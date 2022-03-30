class Parcel < ApplicationRecord
  include Validation

  validates_presence_of :weight, :volume, :source, :destination, :status, :cost
	validate :validate_source_and_destination
  before_create :set_cost
	belongs_to :parcel_owner
	belongs_to :train_booking, optional: true
	enum status: { booked: 'Booked', shipped: 'Shipped', delivered: 'Delivered' }, _default: 'Booked'

  def set_cost
    self.cost = self.weight * 2.5
  end
end
