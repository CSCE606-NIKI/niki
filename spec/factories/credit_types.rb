FactoryBot.define do
  factory :credit_type_with_carry_forward, class: CreditType do
    id {21}
    name { "CreditTypeWithCarryForward" }
    credit_limit { 1000 }
    carry_forward { true }
    description { "Carry Forward is enabled" }
  end

  factory :credit_type_without_carry_forward, class: CreditType do
    id {20}
    name { "CreditTypeWithoutCarryForward" }
    credit_limit { 1000 }
    carry_forward { false }
    description { "Carry Forward is disabled" }
  end
end
