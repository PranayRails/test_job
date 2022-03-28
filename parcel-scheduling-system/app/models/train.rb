# frozen_string_literal: true

class Train < ApplicationRecord
  paginates_per 20
  belongs_to :train_operator

  enum status: { available: 'Available', running: 'Runing', reached: 'Reached' }, _default: 'Available'

  validates_presence_of :source, :destination, :weight_capacity, :status, :cost
  # scope :available_for_parcels, -> (weight, volume) { where('weight_capacity > ? AND volume_capacity > ?', weight, volume ) }

  def self.available_for_parcels(parcel_ids)
    'ABCD 12'
  end
end
