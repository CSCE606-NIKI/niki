class CreateCredits < ActiveRecord::Migration[7.0]
  def change
    create_table :credits do |t|
      t.integer :total_number_of_credits
      t.date :date
      t.integer :amount
      t.string :credit_type
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
