class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :title
      t.date :date
      t.integer :mileage
      t.string :comments

      t.timestamps
    end
  end
end
