require 'rails_helper'

RSpec.describe PostMaster, type: :model do
  before(:example) do
    @trains_operator = TrainOperator.create( name: "Train Operator", email: "train-operator@yopmail.com", password: "train-operator")
    @train = Train.create(name: 'Thomas', source: 'source 1', destination: 'dest 2', weight_capacity: 200, volume_capacity: 10000, status: 'Available', cost: 200, train_operator_id: @trains_operator.id)
    @post_master = PostMaster.create( name: "Post Master", email: "post-master@yopmail.com", password: "post-master")
    @train_booking = TrainBooking.create(departure_time: Time.now, arrival_time: Time.now + 3, status: 'Running', train_id: @train.id, post_master_id: @post_master.id)
  end

  describe "associations" do
    it{ is_expected.to have_many(:train_bookings) }
  end

  it "to be valid" do
    expect(@post_master).to be_valid
  end
end
