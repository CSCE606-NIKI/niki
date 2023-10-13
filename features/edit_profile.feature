# features/edit_profile.feature

Feature: Editing User Profile
  Scenario: User edits their profile
    Given I am a registered user and I am on the login page
    When I fill in "identifier" with "mock@gmail.com"
    And I fill in "password" with "password"
    And I click on "Log in"
    When I visit the edit profile page
    And I fill in "Name" with "John Doe"
    And I fill in "Email" with "john.doe@example.com"
    And I attach the file "app/assets/images/default_profile_pic.jpg" to "Profile Pic"
    When I update my profile with the following information:
      | Name   | Email      |
      | JohnDoe | john@example.com |
    Then I should see "Welcome"