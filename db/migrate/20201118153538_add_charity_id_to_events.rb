class AddCharityIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :charity_id, :integer
  end
end
