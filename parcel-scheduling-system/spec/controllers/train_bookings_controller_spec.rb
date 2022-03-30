# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TrainBookingsController, type: :controller do
  before(:example) do
    @parcel_owner = ParcelOwner.create(name: 'Parcel Owner',
                                       email: 'parcel-owner@yopmail.com',
                                       password: 'parcel-owner')
    @parcel = Parcel.create(weight: 20.3, volume: 30, source: 'source 1',
                            destination: 'dest 2', status: 'Booked',
                            parcel_owner_id: @parcel_owner.id, cost: 50)
    @trains_operator = TrainOperator.create(name: 'Train Operator',
                                            email: 'train-operator@yopmail.com',
                                            password: 'train-operator')
    @train = Train.create(name: 'Thomas', source: 'source 1',
                          destination: 'dest 2', weight_capacity: 200,
                          volume_capacity: 10_000, status: 'Available',
                          cost: 200, train_operator_id: @trains_operator.id)
    @post_master = PostMaster.create(name: 'Post Master',
                                     email: 'post-master@yopmail.com',
                                     password: 'post-master')
    @train_booking = TrainBooking.create(departure_time: Time.now,
                                         arrival_time: Time.now + 3,
                                         status: 'Running',
                                         train_id: @train.id,
                                         post_master_id: @post_master.id)
  end

  describe 'GET /index' do
    it 'sign in the post master and shows the train bookings' do
      sign_in @post_master
      get :index
      expect(@controller.instance_variable_get(:@train_bookings)).to include(@train_booking)
    end
  end

  describe 'POST /create' do
    it 'sign in the post master and allows to create the train booking' do
      sign_in @post_master
      expect do
        post :create, params: {
          train_booking: {
            train_id: @train.id, post_master_id: @post_master.id, parcel_ids: [@parcel.id]
          }
        }
      end.to change { TrainBooking.count }.by(1)
    end
  end

  # describe 'PATCH /update' do
  #   it 'sign in the post master and allows to update the train booking' do
  #     sign_in @post_master
  #     patch :update, params: {
  #       id: @train_booking.id,
  #       train_booking: {
  #         train_id: @train.id
  #       }
  #     }
  #     expect(@controller.instance_variable_get(:@train_booking).train_id).to eq(@train.id)
  #     expect(flash[:success]).to eq('Train booking is successfully updated.')
  #   end
  # end

  describe 'destroy' do
    it 'sign in the post master and allows to destroy the train booking' do
      sign_in @post_master
      expect do
        delete :destroy, params: { id: @train_booking.id }
      end.to change { TrainBooking.count }.by(-1)
    end
  end
end
