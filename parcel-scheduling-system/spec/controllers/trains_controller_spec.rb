require 'rails_helper'

RSpec.describe TrainsController, type: :controller do
  before(:example) do
    @trains_operator = TrainOperator.create( name: "Train Operator", email: "train-operator@yopmail.com", password: "train-operator")
    @train = Train.create(name: 'Thomas', source: 'source 1', destination: 'dest 2', weight_capacity: 200, volume_capacity: 10000, status: 'Available', cost: 200, train_operator_id: @trains_operator.id)
  end

  describe "GET /index" do
    it 'sign in the trains operator and shows the trains' do
      sign_in @trains_operator
      get :index
      expect(@controller.instance_variable_get(:@trains)).to include(@train)
    end
  end

  describe 'POST /create' do
    it 'sign in the trains operator and allows to add the train' do
      sign_in @trains_operator
      expect do
        post :create, params: {
          train: {
            name: 'Elwis', source: 'sour 1', destination: 'dest 2', weight_capacity: 200, volume_capacity: 10000, cost: 200
          }
        }
      end.to change { Train.count }.by(1)
    end
  end

  describe 'PATCH /update' do
    it 'sign in the trains operator and allows to update the train' do
      sign_in @trains_operator
      patch :update, params: {
        id: @train.id,
        train: {
          name: 'Demo'
        }
      }
      expect(@controller.instance_variable_get(:@train).name).to eq('Demo')
      expect(flash[:success]).to eq('Train is successfully updated.')
    end
  end

  describe 'destroy' do
    it 'sign in the trains operator and allows to destroy the train' do
      sign_in @trains_operator
      expect do
        delete :destroy, params: { id: @train.id }
      end.to change {Train.count}.by(-1)
    end
  end
end
