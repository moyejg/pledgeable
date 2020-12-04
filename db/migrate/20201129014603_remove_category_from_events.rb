class RemoveCategoryFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :category
  end
end
