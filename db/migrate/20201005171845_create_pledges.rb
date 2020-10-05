class CreatePledges < ActiveRecord::Migration[6.0]
  def change
    create_table :pledges do |t|
      t.decimal :amount
      t.decimal :max_amount
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
