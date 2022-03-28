class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_train_operator?
    self.type == 'TrainOperator'
  end

  def is_parcel_owner?
    self.type == 'ParcelOwner'
  end

  def is_post_master?
    self.type == 'PostMaster'
  end
end
