class RenamenumberOfCreditsTototalNumberOfCredits < ActiveRecord::Migration[7.0]
  def change
    rename_column :credits, :number_of_credits, :total_number_of_credits

  end
end
