# frozen_string_literal: true

# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  USER_TYPES = ['PostMaster', 'ParcelOwner', 'TrainOperator', nil].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :validate_type

  %i[train_operator post_master parcel_owner].each do |attribute|
    define_method :"#{attribute}?" do
      type == attribute.to_s.classify
    end
  end

  def validate_type
    errors.add(:type, 'Subclass Not Found') unless User::USER_TYPES.include?(type)
  end
end
