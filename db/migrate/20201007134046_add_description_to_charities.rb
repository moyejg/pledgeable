class AddDescriptionToCharities < ActiveRecord::Migration[6.0]
  def change
    add_column :charities, :description, :text
  end
end
