require 'rails_helper'

RSpec.describe Parcel, type: :model do
  before(:example) do
    @parcel_owner = ParcelOwner.create( name: "Parcel Owner", email: "parcel-owner@yopmail.com", password: "parcel-owner")
    @parcel = Parcel.create(weight: 20.3, volume: 30, source: 'source 1', destination: 'dest 2', status: 'Booked', cost: 30.0, parcel_owner_id: @parcel_owner.id)
  end

  describe "associations" do
    it{ is_expected.to belong_to(:parcel_owner) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:volume) }
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:destination) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:cost) }
  end

  it "to be valid" do
    expect(@parcel).to be_valid
  end

  describe 'Parcels calculation for' do
    it "calculate the total weigth" do
      expect(Parcel.sum_weight(@parcel.id)).to eq(20.3)
    end

    it "calculate the total volume" do
      expect(Parcel.sum_volume(@parcel.id)).to eq(30)
    end
  end
end
