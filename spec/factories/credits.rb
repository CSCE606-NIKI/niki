FactoryBot.define do
  factory :credit do
    number_of_credits { 1 }
    date { "2023-10-10" }
    credit_type { "MyString" }
  end
end
