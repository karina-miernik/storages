class CreateStorages < ActiveRecord::Migration[7.0]
  def change
    create_table :storages do |t|
      t.boolean :booked
      t.boolean :book
      t.boolean :available

      t.timestamps
    end
  end
end
