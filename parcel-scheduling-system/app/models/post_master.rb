class PostMaster < User
	has_many :parcels
	has_many :train_bookings, dependent: :destroy
end
