class TrainOperator < User
	has_many :trains, dependent: :destroy
end
