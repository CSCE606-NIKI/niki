class DropPrints < ActiveRecord::Migration[7.0]
  def change
    drop_table :prints
  end
end
