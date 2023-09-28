Feature: Homepage
    As a visitor
    I want to see the homepage
    So that I can learn about CE Tracker    
    
    Scenario: Visit the homepage
        Given I am on the homepage
        When I see "Welcome to CE Tracker"
        Then I should see "Your One-Stop Solution for Managing Continuing Education Credits"
        And I should see "Discover the Easiest Way to Keep Track of Your Education Progress"
        And I should see "Login"
        And I should see "Sign Up"
        
    Scenario: Click "Login" button
        Given I am on the homepage
        When I click "Login"
        Then I should be on the login page

    Scenario: Click "Sign Up" button
        Given I am on the homepage
        When I click "Sign Up"
        Then I should be on the sign-up page

    Scenario: Verify "Login" button styling
        Given I am on the homepage
        Then the "Login" button should have the class "login-button"

    Scenario: Verify "Sign Up" button styling
        Given I am on the homepage
        Then the "Sign Up" button should have the class "signup-button"

    Scenario: Click "Login" button hover effect
        Given I am on the homepage
        When I hover over the "Login" button
        Then the "Login" button color should change to "#0056b3"

    Scenario: Click "Sign Up" button hover effect
        Given I am on the homepage
        When I hover over the "Sign Up" button
        Then the "Sign Up" button color should change to "#0056b3"

