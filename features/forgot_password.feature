Feature: Forgot Password
  As a registered user
  I want to reset my password
  So that I can regain access to my account

  Scenario: User requests a password reset link
    Given I am on the login form
    When I click on the "Forgot Password?" link
    Then I should see a password reset form

  Scenario: User submits a valid email for password reset
    Given I am on the password reset page
    When I enter my email "user@example.com"
    And I click the "Reset Password" button
    Then I should see a message displaying "If an account with that email was found, we have sent a link to reset the password"

  Scenario: User submits an invalid email for password reset
    Given I am on the password reset page
    When I enter an invalid email "invalid_email"
    And I click "Reset Password" button
    Then I should see a message displaying "If an account with that email was found, we have sent a link to reset the password"

  Scenario: User resets their password
    Given a user with email "test@example.com" exists
    When I request a password reset for "test@example.com"
    Then I should see a password reset page
    And I should be able to enter a new password
    And I should get a success message



