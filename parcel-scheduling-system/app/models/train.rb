# frozen_string_literal: true

class Train < ApplicationRecord
  paginates_per 20

  STATIONS = %w [
    "A",
    "B",
    "C"
  ]

  belongs_to :train_operator

  enum status: { available: 'Available', running: 'Running', reached: 'Reached' }, _default: 'Available'

  validates_presence_of :name, :source, :destination, :weight_capacity, :status, :cost
  validate :validate_source_and_destination

  def self.available_for_parcels(parcel_ids)
    where('weight_capacity > ? AND volume_capacity > ?', Parcel.sum_weight(parcel_ids), Parcel.sum_volume(parcel_ids)).available.order(:weight_capacity, :volume_capacity)
  end

  def validate_source_and_destination
    if source == destination
      errors.add(:base, "source and destination can't be same.")
    end
  end
end
