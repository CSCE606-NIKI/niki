Feature: Facebook Login/Sign Up
    As a visitor
    I want to sign up for an account with my existing Facebook account
    So that I can access the application

    As an existing user
    I want to log in with my existing Facebook account
    So that I can access the application

    # @facebook_test1
    # Scenario: Valid sign up with Facebook account
    # Given I am a new user and I am on the sign up page
    # When I click "Sign up with Facebook" and choose my valid Facebook account
    # Then I should see "Dashboard"

    @facebook_test0
    Scenario: Invalid sign up with Facebook account
        Given I am a new user and I am on the sign up page
        When I click "Sign up with Facebook" and choose my invalid Facebook account
        Then I should see "Log In"
    
    # @facebook_test1
    # Scenario: Valid login with Facebook account
    # Given I am an existing user and I am on the login page
    # When I click "Log in with Facebook" and choose my valid Facebook account
    # Then I should see "Dashboard"
    
    @facebook_test0
    Scenario: Invalid login with Facebook account
        Given I am an existing user and I am on the login page
        When I click "Log in with Facebook" and choose my invalid Facebook account
        Then I should see "Log In"