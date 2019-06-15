class AddForeignKeyToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :car_id, :integer
  end
end
