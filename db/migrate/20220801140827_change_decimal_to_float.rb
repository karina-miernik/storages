class ChangeDecimalToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :storages, :x, :float
    change_column :storages, :y, :float
  end
end
