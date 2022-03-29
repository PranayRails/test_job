# frozen_string_literal: true

class Train < ApplicationRecord
  include Validation
  paginates_per 20

  STATIONS = [
    "A",
    "B",
    "C"
  ]

  belongs_to :train_operator

  enum status: { available: 'Available', running: 'Running', reached: 'Reached' }, _default: 'Available'

  validates_presence_of :name, :source, :destination, :weight_capacity, :status, :cost
  validate :validate_source_and_destination

  def self.available_for_parcels(parcels)
    ids = parcels.ids
    where(source: parcels.first.source, destination: parcels.first.destination).where('weight_capacity > ? AND volume_capacity > ?', Parcel.sum_weight(ids), Parcel.sum_volume(ids)).available.order(:weight_capacity, :volume_capacity)
  end

end
