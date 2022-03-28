class Parcel < ApplicationRecord
  validates_presence_of :weight, :volume, :source, :destination, :status, :cost
end
