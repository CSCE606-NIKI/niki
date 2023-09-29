Feature: Forgot Password
  As a registered user
  I want to reset my password
  So that I can regain access to my account

  Scenario: User requests a password reset link
    Given I am on the login page
    When I click on the "Forgot Password" link
    Then I should see a password reset form

  Scenario: User submits a valid email for password reset
    Given I am on the password reset page
    When I enter my email "user@example.com"
    And I click the "Reset" button
    Then I should receive a password reset email

  Scenario: User submits an invalid email for password reset
    Given I am on the password reset page
    When I enter an invalid email "invalid_email"
    And I click the "Submit" button
    Then I should see an error message

