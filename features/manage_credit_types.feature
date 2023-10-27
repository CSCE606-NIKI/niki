Feature: Manage Credit Types
  As an admin user
  I want to add new credit types
  So that I can manage credit type settings
  Background:
        Given I am logged in as "user@example.com" with password "password123"
  
  Scenario: Add a new credit type
    When I visit the new credit type page
    And I fill in "Name" with "Type1"
    And I fill in "Credit limit" with "1000"
    And I check "Carry forward"
    And I press "Create Credit type"
    Then I should see "Credit type created successfully."

  Scenario: Add a new credit type without carry forward
    When I visit the new credit type page
    And I fill in "Name" with "Type2"
    And I fill in "Credit limit" with "500"
    And I uncheck "Carry forward"
    And I press "Create Credit type"
    Then I should see "Credit type created successfully."
