require 'faker'

FactoryBot.define do
  factory :user do
    username { Faker::Name.name } # Use Faker gem to generate random names
    email { Faker::Internet.email }
    password { 'password' } # Set a default password for testing
    # Add other attributes as needed
  end
end
