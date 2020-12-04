class ChangePrecisionScaleInPledges < ActiveRecord::Migration[6.0]
  def change
    change_column :pledges, :amount, :decimal, precision: 10, scale: 2
    change_column :pledges, :max_amount, :decimal, precision: 10, scale: 2
  end
end
