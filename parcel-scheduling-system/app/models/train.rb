# frozen_string_literal: true

# Train
class Train < ApplicationRecord
  include Validation
  paginates_per 20

  STATIONS = %w[A B C].freeze

  belongs_to :train_operator

  enum status: { available: 'Available', running: 'Running', reached: 'Reached', unavailable: 'Unavailable' }, _default: 'Available'

  validates_presence_of :name, :source, :destination, :weight_capacity, :status, :cost
  validate :validate_source_and_destination

  def self.available_for_parcels(parcels)
    where('weight_capacity > ? AND volume_capacity > ? AND source = ? AND destination = ?', parcels.sum(:weight), parcels.sum(:volume), parcels.first.source, parcels.first.destination).available.order(
      :weight_capacity, :volume_capacity
    )
  end
end
