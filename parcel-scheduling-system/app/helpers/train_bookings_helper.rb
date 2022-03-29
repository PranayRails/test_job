module TrainBookingsHelper
  def get_trains
  	parcels = Parcel.where(id: @parcel_ids)
  	trains = Train.where(source: parcels.first.source, destination: parcels.first.destination)
	  trains.available_for_parcels(@parcel_ids)
  end
end
