class AddPositionAndDimensionsToStorages < ActiveRecord::Migration[7.0]
  def change
    add_column :storages, :x, :decimal, precision: 4, scale: 1
    add_column :storages, :y, :decimal, precision: 4, scale: 1
    add_column :storages, :width, :decimal
    add_column :storages, :height, :decimal
  end
end
