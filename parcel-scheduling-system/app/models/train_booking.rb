# frozen_string_literal: true

# TrainBooking
class TrainBooking < ApplicationRecord
  attr_accessor :parcel_ids

  has_many :parcels
  belongs_to :train
  belongs_to :post_master

  accepts_nested_attributes_for :parcels

  enum status: { running: 'Running', completed: 'Completed' }, _default: 'Running'

  validates_presence_of :train_id, :post_master_id, :status

  before_create :add_attributes
  after_create :update_train!, :parcels_train_booking!

  def add_attributes
    self.departure_time = Time.now
    self.arrival_time = Time.now + 3.hours
  end

  def parcel_ids=(val = [])
    @parcel_ids = val.split(' ')
  end

  def update_train!
    train.running!
    UpdateTrainJob.set(wait_until: arrival_time).perform_later(id)
  end

  def parcels_train_booking!
    parcels = Parcel.where(id: parcel_ids)
    parcels.update_all(status: 'shipped', train_booking_id: id)
  end

  def self.busy_lines?(parcels)
    joins(:train).where(trains: { source: parcels.first.source, destination: parcels.first.destination,
                                  status: 'running' })
  end
end
