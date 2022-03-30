# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TrainBooking, type: :model do
  before(:example) do
    @trains_operator = TrainOperator.create(name: 'Train Operator',
                                            email: 'train-operator@yopmail.com',
                                            password: 'train-operator')
    @train = Train.create(name: 'Thomas', source: 'source 1',
                          destination: 'dest 2', weight_capacity: 200,
                          volume_capacity: 10_000, status: 'Available',
                          cost: 200, train_operator_id: @trains_operator.id)
    @parcel_owner = ParcelOwner.create(name: 'Parcel Owner',
                                       email: 'parcel-owner@yopmail.com',
                                       password: 'parcel-owner')
    @parcel = Parcel.create(weight: 20.3, volume: 30, source: 'source 1',
                            destination: 'dest 2', status: 'Booked',
                            cost: 30.0, parcel_owner_id: @parcel_owner.id)
    @post_master = PostMaster.create(name: 'Post Master',
                                     email: 'post-master@yopmail.com',
                                     password: 'post-master')
    @train_booking = TrainBooking.create(departure_time: Time.now,
                                         arrival_time: Time.now + 3,
                                         status: 'Running',
                                         train_id: @train.id,
                                         post_master_id: @post_master.id)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:train) }
    it { is_expected.to belong_to(:post_master) }
    it { is_expected.to have_many(:parcels) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:status) }
  end

  it 'to be valid' do
    expect(@train_booking).to be_valid
  end
end
