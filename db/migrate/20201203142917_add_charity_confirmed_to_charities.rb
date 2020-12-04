class AddCharityConfirmedToCharities < ActiveRecord::Migration[6.0]
  def change
    add_column :charities, :charity_confirmed, :boolean, default: false
  end
end
