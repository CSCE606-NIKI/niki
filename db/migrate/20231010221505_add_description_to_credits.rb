class AddDescriptionToCredits < ActiveRecord::Migration[7.0]
  def change
    add_column :credits, :description, :text
  end
end
