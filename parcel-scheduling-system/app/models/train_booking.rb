class TrainBooking < ApplicationRecord
	has_many :parcels
	belongs_to :train
	belongs_to :post_master

	accepts_nested_attributes_for :parcels

  enum status: { running: 'Running', completed: 'Completed'}, _default: 'Running'

  validates_presence_of :departure_time, :arrival_time, :source, :destination, :status
end
