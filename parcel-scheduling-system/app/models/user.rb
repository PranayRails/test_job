# frozen_string_literal: true

# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  USER_TYPES = ['PostMaster', 'ParcelOwner', 'TrainOperator', nil].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :validate_type

  def train_operator?
    type == 'TrainOperator'
  end

  def parcel_owner?
    type == 'ParcelOwner'
  end

  def post_master?
    type == 'PostMaster'
  end

  def validate_type
    errors.add(:type, 'Subclass Not Found') unless User::USER_TYPES.include?(type)
  end
end
