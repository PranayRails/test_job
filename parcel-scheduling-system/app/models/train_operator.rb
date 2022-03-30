# frozen_string_literal: true

class TrainOperator < User
  has_many :trains, dependent: :destroy
end
