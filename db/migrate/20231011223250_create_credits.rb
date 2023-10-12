class CreateCredits < ActiveRecord::Migration[7.0]
  def change
    create_table :credits do |t|
      t.integer :creditID
      t.date :date
      t.string :status
      t.string :type
      t.integer :credit_value
      t.text :description

      t.timestamps
    end
  end
end
