require 'rails_helper'

RSpec.describe Train, type: :model do
  before(:example) do
    @trains_operator = TrainOperator.create( name: "Train Operator", email: "train-operator@yopmail.com", password: "train-operator")
    @train = Train.new(name: 'Thomas', source: 'source 1', destination: 'dest 2', weight_capacity: 200, volume_capacity: 10000, status: 'Available', cost: 200, train_operator_id: @trains_operator.id)
  end

  describe "associations" do
    it{ is_expected.to belong_to(:train_operator) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:weight_capacity) }
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:destination) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:cost) }
  end

  it "to be valid" do
    expect(@train).to be_valid
  end
end
