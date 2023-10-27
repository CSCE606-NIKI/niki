class CreateCreditTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_types do |t|
      t.string :name
      t.integer :credit_limit
      t.boolean :carry_forward
      t.text :description

      t.timestamps
    end
  end
end
