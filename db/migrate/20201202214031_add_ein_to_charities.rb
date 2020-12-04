class AddEinToCharities < ActiveRecord::Migration[6.0]
  def change
    add_column :charities, :ein, :string
  end
end
