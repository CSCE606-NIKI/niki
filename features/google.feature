Feature: Google Login/Sign Up
    As a visitor
    I want to sign up for an account with my existing Google account
    So that I can access the application

    As an existing user
    I want to log in with my existing Google account
    So that I can access the application

    @google_test1
    Scenario: Valid sign up with Google account
        Given I am a new user and I am on the sign up page
        When I click "Sign up with Google" and choose my valid Google account
        Then I should see "Set Renewal Date"

    @google_test0
    Scenario: Invalid sign up with Google account
        Given I am a new user and I am on the sign up page
        When I click "Sign up with Google" and choose my invalid Google account
        Then I should see "Log In"
    
    @google_test1
    Scenario: Valid login with Google account
        Given I am an existing user and I am on the login page
        When I click "Log in with Google" and choose my valid Google account
        Then I should see "Add New Credit Type"
    
    @google_test1
    Scenario: Sign up with an already registered email
        Given I am a new user and I am on the sign up page
        And someone else has already registered with my email
        When I click "Sign up with Google" and choose my valid Google account
        Then I should see "This email is already being used with a different sign-in method"