Feature: Homepage
    As a visitor
    I want to see the homepage
    So that I can learn about CE Tracker

Scenario: Verify homepage content
    Given I am on the homepage
    Then I should see "CE Tracker"
    And I should see "Login"
    And I should see "Sign Up"
    And the "CE Tracker" link should have the class "nav-link"
    And the "Login" button should have the class "login-button"
    And the "Sign Up" button should have the class "signup-button"
 

Scenario: Click "Login" button
    Given I am on the homepage
    When I click the "Login" button

Scenario: Click "Sign up" button
    Given I am on the homepage
    When I click the "Sign Up" button

