require 'faker'

FactoryBot.define do
  
  factory :user do
    username { Faker::Name.name } # Use Faker gem to generate random names
    email { Faker::Internet.email }
    password { 'password' } # Set a default password for testing
    renewal_date { Date.new(2021, 12, 30) } # Set a fixed renewal date
    start_date { Date.new(2020, 12, 30) }   # Set a fixed start date
    # Add other attributes as needed
  end

  # Define a factory for a user with a specific renewal date
  factory :user_with_different_renewal_date, class: User do
    username { Faker::Name.name }
    email { 'fake@niki.com' }
    password { 'password' }
    renewal_date { Date.tomorrow } # Set a different renewal date
    start_date { Date.new(2021, 1, 15) }   # Set a different start date
  end

  
  factory :credit_type_with_carry_forward, class: CreditType do
    id {21}
    name { "CreditTypeWithCarryForward" }
    credit_limit { 5 }
    carry_forward { true }
    description { "Carry Forward is enabled" }
    user { association :user } # Include this line to associate the credit type with a user

  end

  factory :credit_type_without_carry_forward, class: CreditType do
    id {20}
    name { "CreditTypeWithoutCarryForward" }
    credit_limit { 1000 }
    carry_forward { false }
    description { "Carry Forward is disabled" }
    user { association :user } # Include this line to associate the credit type with a user
  end

  factory :credit_type do
    sequence(:name) { |n| "CreditType#{n}" }
    credit_limit { 100 }
    carry_forward { true }
    user
  end
end
