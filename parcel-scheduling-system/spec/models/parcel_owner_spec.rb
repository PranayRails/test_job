require 'rails_helper'

RSpec.describe ParcelOwner, type: :model do
  before(:example) do
    @parcel_owner = ParcelOwner.create( name: "Parcel Owner", email: "parcel-owner@yopmail.com", password: "parcel-owner")
    @parcel = Parcel.create(weight: 20.3, volume: 30, source: 'source 1', destination: 'dest 2', status: 'Booked', cost: 30.0, parcel_owner_id: @parcel_owner.id)
  end

  describe "associations" do
    it{ is_expected.to have_many(:parcels) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  it "to be valid" do
    expect(@parcel_owner).to be_valid
  end
end
