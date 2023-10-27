class CreditType < ApplicationRecord
    has_many :credits
    belongs_to :user
 
    validates :name , uniqueness: true ,presence: true 
    validates :credit_limit , numericality: { greater_than: 0 }
    before_validation :set_default_carry_forward

    private
    def set_default_carry_forward
      self.carry_forward = false if carry_forward.nil?
    end
end
