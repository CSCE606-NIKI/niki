# features/support/simplecov.rb
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'spec/support'
  add_filter /_test\.rb$/
  # Additional configuration options can be added here
end
