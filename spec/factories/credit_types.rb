FactoryBot.define do
  factory :credit_type do
    name { "MyString" }
    credit_limit { 1 }
    carry_forward { false }
    description { "MyText" }
  end
end
