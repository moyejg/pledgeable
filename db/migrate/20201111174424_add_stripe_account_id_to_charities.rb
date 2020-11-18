class AddStripeAccountIdToCharities < ActiveRecord::Migration[6.0]
  def change
    add_column :charities, :stripe_account_id, :string
  end
end
