class CreateCredits < ActiveRecord::Migration[7.0]
  def change
    create_table :credits do |t|
      t.integer :number_of_credits
      t.date :date
      t.string :credit_type

      t.timestamps
    end
  end
end
