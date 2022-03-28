class AddNameToTrain < ActiveRecord::Migration[6.1]
  def change
    add_column :trains, :name, :string
  end
end
