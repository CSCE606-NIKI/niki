# features/sign_up.feature

Feature: User Sign Up
  As a visitor
  I want to sign up for an account
  So that I can access the application

  Scenario: Valid Sign Up
      Given I am new user and I am on the user new page
      When I fill in "Username" with "test_user"
      And I fill in "Email" with "test@example.com"
      And I fill in "Password" with "Password123!"
      And I fill in "Password confirmation" with "Password123!" 
      And I click on "Sign up"
      Then I should see "Log In"

  Scenario: Passwords mismatch
      Given I am new user and I am on the user new page
      When I fill in "Username" with "test_user"
      And I fill in "Email" with "test@example.com"
      And I fill in "Password" with "Password123!"
      And I fill in "Password confirmation" with "Password123" 
      And I click on "Sign up"
      Then I should see "Passwords Mismatch"

  Scenario: Invalid password, missing special character
      Given I am new user and I am on the user new page
      When I fill in "Username" with "test_user"
      And I fill in "Email" with "test@example.com"
      And I fill in "Password" with "Password123"
      And I fill in "Password confirmation" with "Password123" 
      And I click on "Sign up"
      Then I should see "Invalid password"

   Scenario: Invalid password, missing lowercase character
      Given I am new user and I am on the user new page
      When I fill in "Username" with "test_user"
      And I fill in "Email" with "test@example.com"
      And I fill in "Password" with "PASSWORD123!"
      And I fill in "Password confirmation" with "PASSWORD123!" 
      And I click on "Sign up"
      Then I should see "Invalid password"

   Scenario: Invalid password, missing uppercase character
      Given I am new user and I am on the user new page
      When I fill in "Username" with "test_user"
      And I fill in "Email" with "test@example.com"
      And I fill in "Password" with "password123!"
      And I fill in "Password confirmation" with "password123!" 
      And I click on "Sign up"
      Then I should see "Invalid password"

   Scenario: Invalid password, missing digit.
      Given I am new user and I am on the user new page
      When I fill in "Username" with "test_user"
      And I fill in "Email" with "test@example.com"
      And I fill in "Password" with "Password!"
      And I fill in "Password confirmation" with "Password!" 
      And I click on "Sign up"
      Then I should see "Invalid password"

   Scenario: Invalid password, shorter length.
      Given I am new user and I am on the user new page
      When I fill in "Username" with "test_user"
      And I fill in "Email" with "test@example.com"
      And I fill in "Password" with "Pa12!"
      And I fill in "Password confirmation" with "Pa12!" 
      And I click on "Sign up"
      Then I should see "Invalid password"