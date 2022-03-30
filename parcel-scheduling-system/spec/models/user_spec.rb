# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @train_operator = TrainOperator.create(
      name: 'Train Operator',
      email: 'train-operator@yopmail.com',
      password: 'train-operator'
    )

    @post_master = PostMaster.create(
      name: 'Post Master',
      email: 'post-master@yopmail.com',
      password: 'post-master'
    )

    @parcel_owner = ParcelOwner.create(
      name: 'Parcel Owner',
      email: 'parcel-owner@yopmail.com',
      password: 'parcel-owner'
    )
  end

  describe 'expects user to be' do
    it 'train-operator' do
      expect(@train_operator.train_operator?).to eq(true)
    end

    it 'post-master' do
      expect(@post_master.post_master?).to eq(true)
    end

    it 'parcel-owner' do
      expect(@parcel_owner.parcel_owner?).to eq(true)
    end
  end
end
