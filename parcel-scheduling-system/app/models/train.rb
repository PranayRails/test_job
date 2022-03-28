# frozen_string_literal: true

class Train < ApplicationRecord
  paginates_per 20
  belongs_to :train_operator

  enum status: { available: 'Available', running: 'Runing', reached: 'Reached' }, _default: 'Available'

  validates_presence_of :source, :destination, :weight_capacity, :status, :cost
end
