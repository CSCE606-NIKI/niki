class Credit < ApplicationRecord
    belongs_to :user
    validates :credit_type, presence: true
    validates :date, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :total_number_of_credits, presence: true, numericality: { greater_than_or_equal_to: 0 }
    CREDIT_LIMITS = {
      'Credit_type1' => 100,
      'Credit_type2' => 200,
      'Credit_type3' => 300
    }
    CREDIT_TYPES = ['Credit_type1', 'Credit_type2', 'Credit_type3']

end

