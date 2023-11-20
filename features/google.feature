Feature: Internal Google Login/Sign Up
    As a visitor
    I want to sign up for an account with my existing TAMU Google account
    So that I can access the application

    As an existing user
    I want to log in with my existing TAMU Google account
    So that I can access the application

    # @google_test1
    # Scenario: Valid sign up with TAMU account
    # Given I am a new user and I am on the sign up page
    # When I click "Sign up with Google" and choose my valid TAMU account
    # Then I should see "Dashboard"

    @google_test0
    Scenario: Invalid sign up with TAMU account
        Given I am a new user and I am on the sign up page
        When I click "Sign up with Google" and choose my invalid TAMU account
        Then I should see "Log In"
    
    # @google_test1
    # Scenario: Valid login with TAMU account
    # Given I am an existing user and I am on the login page
    # When I click "Log in with Google" and choose my valid TAMU account
    # Then I should see "Dashboard"
    
    @google_test0
    Scenario: Invalid login with TAMU account
        Given I am an existing user and I am on the login page
        When I click "Log in with Google" and choose my invalid TAMU account
        Then I should see "Log In"