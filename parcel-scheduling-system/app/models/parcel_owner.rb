class ParcelOwner < User
	has_many :parcels

  validates_presence_of :name, :email
end
