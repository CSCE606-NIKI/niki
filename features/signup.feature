Feature: User Signup
  As a potential user
  I want to sign up for an account
  So that I can access the application

  Scenario: Successful user signup
    Given I go to the URL "http://localhost:3000/users/sign_up"
    Then the page should have "Sign up"
    When I fill in the following information
      | Email                 | niki@example.com |
      | Password              | niki123          |
      | Password confirmation | niki123             |
    And I click the "Sign up" button
    And I should be logged in

  Scenario: Signup with existing email
    Given I go to the URL "http://localhost:3000/users/sign_up"
    When I fill in the following information:
      | Email    | niki@example.com |
      | Password | niki123                |
    And I click the "Sign up" button
    Then I should see an error message

  Scenario: Signup with missing information
    Given I go to the URL "http://localhost:3000/users/sign_up"
    When I fill in the following information:
      | Email    | niki@example.com |
      | Password | niki123          |
    And I click the "Sign up" button
    Then I should see a missing field error
