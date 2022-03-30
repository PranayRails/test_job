# frozen_string_literal: true

# Parcel
class Parcel < ApplicationRecord
  include Validation

  validates_presence_of :weight, :volume, :source, :destination, :status, :cost
  validate :validate_source_and_destination
  before_create :set_cost
  before_destroy :can_destroy?
	belongs_to :parcel_owner
	belongs_to :train_booking, optional: true
	enum status: { booked: 'Booked', shipped: 'Shipped', delivered: 'Delivered' }, _default: 'Booked'

  def set_cost
    self.cost = weight * 2.5
  end

  def can_destroy?
    errors.add(:base, "Parcel cannot be deleted") unless booked?
  end
end
