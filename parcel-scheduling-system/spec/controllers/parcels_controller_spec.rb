# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParcelsController, type: :controller do
  before(:example) do
    @parcel_owner = ParcelOwner.create(name: 'Parcel Owner', email: 'parcel-owner@yopmail.com',
                                       password: 'parcel-owner')
    @parcel = Parcel.create(weight: 20.3, volume: 30, source: 'source 1', destination: 'dest 2', status: 'Booked',
                            cost: 30.0, parcel_owner_id: @parcel_owner.id)
  end

  describe 'GET /index' do
    it 'sign in the parcel owner and shows the parcel' do
      sign_in @parcel_owner
      get :index
      expect(@controller.instance_variable_get(:@parcels)).to include(@parcel)
    end
  end

  describe 'POST /create' do
    it 'sign in the parcel owner and allows to create the parcel' do
      sign_in @parcel_owner
      expect do
        post :create, params: {
          parcel: {
            weight: 20.3,
            volume: 30,
            source: 'source 1',
            destination: 'dest 2',
            status: 'Booked',
            cost: 30.0,
            parcel_owner_id: @parcel_owner.id
          }
        }
      end.to change { Parcel.count }.by(1)
    end
  end

  describe 'PATCH /update' do
    it 'sign in the parcel owner and allows to update the parcel' do
      sign_in @parcel_owner
      patch :update, params: {
        id: @parcel.id,
        parcel: {
          weight: 40.3
        }
      }
      expect(@controller.instance_variable_get(:@parcel).weight).to eq(40.3)
      expect(flash[:success]).to eq('Parcel is successfully updated')
    end
  end

  describe 'destroy' do
    it 'sign in the parcel owner and allows to destroy the parcel' do
      sign_in @parcel_owner
      expect do
        delete :destroy, params: { id: @parcel.id }
      end.to change { Parcel.count }.by(-1)
    end
  end
end
