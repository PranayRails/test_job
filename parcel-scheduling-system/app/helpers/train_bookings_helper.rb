module TrainBookingsHelper
  def get_trains
    Train.all.map{|train| ["#{train.source}-#{train.destination}", train.id]}
  end
end
