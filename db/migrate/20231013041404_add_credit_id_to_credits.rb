class AddCreditIdToCredits < ActiveRecord::Migration[7.0]
  def change
    add_column :credits, :creditID, :integer
  end
end
