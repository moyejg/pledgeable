class RemoveAmountsFromPledges < ActiveRecord::Migration[6.0]
  def change
    remove_column :pledges, :amount
    remove_column :pledges, :max_amount
  end
end
