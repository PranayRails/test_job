class TrainBooking < ApplicationRecord
	has_many :parcels
	belongs_to :train
	belongs_to :post_master

	accepts_nested_attributes_for :parcels
end
