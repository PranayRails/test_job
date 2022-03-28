class ParcelOwner < User
	has_many :parcels

  validates_presence_of :weight, :volume, :source, :destination, :status, :cost
end
