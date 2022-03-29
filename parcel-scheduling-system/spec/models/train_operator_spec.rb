require 'rails_helper'

RSpec.describe TrainOperator, type: :model do
  before(:example) do
    @trains_operator = TrainOperator.create( name: "Train Operator", email: "train-operator@yopmail.com", password: "train-operator")
    @train = Train.new(source: 'source 1', destination: 'dest 2', weight_capacity: 200, volume_capacity: 10000, status: 'Available', cost: 200, train_operator_id: @trains_operator.id)
  end

  describe "associations" do
    it{ is_expected.to have_many(:trains) }
  end

  it "to be valid" do
    expect(@train).to be_valid
  end
end
