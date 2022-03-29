class UpdateTrainJob
   queue_as :default

  def perform(train_booking_id)
    train_booking = TrainBooking.find_by_id(train_booking_id)
    train = train_booking.train
    parcels = train_booking.parcels

    # update train status
    train.reached!

    # swap source and destination
    train.update(source: train.destination, destination: train.source)

    # update parcels status
    parcels.each(&:delivered!)

    # update train booking status
    train_booking.complete!
  end
end
