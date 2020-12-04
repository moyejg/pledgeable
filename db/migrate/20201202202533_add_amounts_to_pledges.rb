class AddAmountsToPledges < ActiveRecord::Migration[6.0]
  def change
    add_column :pledges, :amount, :decimal
    add_column :pledges, :max_amount, :decimal
  end
end
