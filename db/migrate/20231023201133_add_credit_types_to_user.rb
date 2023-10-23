class AddCreditTypesToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :credit_type, null: false, foreign_key: true
  end
end
