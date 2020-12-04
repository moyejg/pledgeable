class CreateEventCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :event_categories do |t|
      t.string :name
      t.text :description
      t.string :unit_of_measurement

      t.timestamps
    end
  end
end
