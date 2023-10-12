FactoryBot.define do
  factory :credit do
    creditID { 1 }
    date { "2023-10-11" }
    status { "MyString" }
    type { "" }
    credit_value { 1 }
    description { "MyText" }
  end
end
