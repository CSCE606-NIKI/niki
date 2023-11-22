class Credit < ApplicationRecord
    belongs_to :user
    belongs_to :credit_type

    # validates :credit_type, presence: true
    validates :date, presence: true
    validates :amount, presence: true
    validates :total_number_of_credits, numericality: { greater_than_or_equal_to: 0 }

end

