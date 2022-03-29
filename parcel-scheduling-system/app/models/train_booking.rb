class TrainBooking < ApplicationRecord
	attr_accessor :parcels

	has_many :parcels
	belongs_to :train
	belongs_to :post_master

	accepts_nested_attributes_for :parcels

  enum status: { running: 'Running', completed: 'Completed'}, _default: 'Running'

  validates_presence_of :train_id, :post_master_id, :status

  before_create :add_attributes
  after_create :update_train
  after_create :update_parcels

  def add_attributes
  	self.departure_time = Time.now
  	self.arrival_time = Time.now + 3.hours
  end

  def update_train
  	self.train.running!
  end

  def update_parcels
  	Parcel.where(id: parcels.split(' ')).each(&:shipped!)
  end
end
