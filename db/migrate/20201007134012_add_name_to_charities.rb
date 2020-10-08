class AddNameToCharities < ActiveRecord::Migration[6.0]
  def change
    add_column :charities, :name, :string
  end
end
