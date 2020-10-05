class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :category
      t.decimal :amount
      t.datetime :event_completed_on
      t.integer :user_id

      t.timestamps
    end
  end
end
