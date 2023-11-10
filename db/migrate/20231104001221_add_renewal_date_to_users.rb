class AddRenewalDateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :renewal_date, :date
  end
end
