class ChangeCreditTypeIdToNullable < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :credit_type_id, :integer, null: true
  end
end
