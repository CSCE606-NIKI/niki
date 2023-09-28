Feature: Navbar Styling
    As a user
    I want to verify the styling of the navigation bar

    Scenario: Verify background color of the navbar
        Given I am on the homepage
        Then the navbar should have the background color "#007bff"

    Scenario: Verify text color of navbar links
        Given I am on the homepage
        Then the navbar links should have text color "white"

    Scenario: Verify "CE tracker" link
        Given I am on the homepage
        Then I should see a link with text "CE tracker"

    Scenario: Verify "Profile" dropdown
        Given I am on the homepage
        Then I should see a dropdown link with text "Profile"

    Scenario: Verify "Edit Profile" link in dropdown
        Given I am on the homepage
        When I click the "Profile" dropdown
        Then I should see a link with text "Edit Profile"

    Scenario: Verify "Logout" button in dropdown
        Given I am on the homepage
        When I click the "Profile" dropdown
        Then I should see a "Logout" button with the class "btn-custom"

    Scenario: Verify "Log in" button in dropdown
        Given I am on the homepage
        When I click the "Profile" dropdown
        Then I should see a "Log in" button with the class "btn-custom"

    Scenario: Verify "Sign up" button in dropdown
        Given I am on the homepage
        When I click the "Profile" dropdown
        Then I should see a "Sign up" button with the class "btn-custom"
