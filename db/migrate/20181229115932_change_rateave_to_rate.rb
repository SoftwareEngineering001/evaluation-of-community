class ChangeRateaveToRate < ActiveRecord::Migration
  def change
    change_column :rates, :average_rate, :float
  end
end
