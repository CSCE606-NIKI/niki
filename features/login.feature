Feature: User Login
    As a registered user 
    I want to login to my account
    So that I can access my dashboard
    
    @with-mock-user
    Scenario: Successful Login on entering correct email and password
        Given I am a registered user and I am on the login page
        When I fill in "identifier" with "mock@gmail.com"
        And I fill in "password" with "password"
        And I click on "Log in"
        Then I should see "Welcome"

    @with-mock-user
    Scenario: Successful Login on entering correct username and password
        Given I am a registered user and I am on the login page
        When I fill in "identifier" with "mockuser"
        And I fill in "password" with "password"
        And I click on "Log in"
        Then I should see "Welcome"

    Scenario: Unsuccessful Login on entering incorrect password
        Given I am a registered user and I am on the login page
        When I fill in "identifier" with "mock@gmail.com"
        And I fill in "password" with "wrong_password"
        And I click on "Log in"
        Then I should see "Invalid credentials"
    
    Scenario: Unsuccessful Login on entering incorrect email
        Given I am on the login page
        When I fill in "identifier" with "doesnotexist@gmail.com"
        And I fill in "password" with "password"
        And I click on "Log in"
        Then I should see "Invalid credentials"
    
    Scenario: Unsuccessful Login on entering incorrect username
        Given I am on the login page
        When I fill in "identifier" with "doesnotexist"
        And I fill in "password" with "password"
        And I click on "Log in"
        Then I should see "Invalid credentials"