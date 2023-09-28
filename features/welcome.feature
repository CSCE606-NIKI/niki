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
