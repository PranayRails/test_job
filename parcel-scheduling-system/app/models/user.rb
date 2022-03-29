class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def train_operator?
    self.type == 'TrainOperator'
  end

  def parcel_owner?
    self.type == 'ParcelOwner'
  end

  def post_master?
    self.type == 'PostMaster'
  end
end
