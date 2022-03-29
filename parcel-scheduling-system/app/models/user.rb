class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  USER_TYPES = ["PostMaster", "ParcelOwner", "TrainOperator", nil]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :validate_type

  def train_operator?
    self.type == 'TrainOperator'
  end

  def parcel_owner?
    self.type == 'ParcelOwner'
  end

  def post_master?
    self.type == 'PostMaster'
  end

  def validate_type
    errors.add(:type, "Subclass Not Found") unless User::USER_TYPES.include?(self.type)
  end
end
