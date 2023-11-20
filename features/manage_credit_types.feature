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

  Scenario: Edit a existed credit type
    Given I have added a credit type
    When I visit the Add New credit page
    And I fill in the following:
    | Field        | Value       |
    | Credit type  | Type        |
    | Date         | 2023-10-11  |
    | Amount       | 3           |
    | Description  | Test credit |
    And I click the "Create Credit" button
    Then I should be redirected to the dashboard
    And I should see the "Show this Credit Type" link for the new credit type
    When I click link "Show this Credit Type"
    Then I should see Edit button
    When I click on Edit button
    Then I should be directed to edit_credit_type_path
    When I fill in "Credit limit" with "10"
    And click Update Credit type
    Then I should be redirected to Dashboard
    And should see a message

  Scenario: Delete credit type
    Given I have added a credit type
    When I visit the Add New credit page
    And I fill in the following:
    | Field        | Value       |
    | Credit type  | Type        |
    | Date         | 2023-10-11  |
    | Amount       | 3           |
    | Description  | Test credit |
    And I click the "Create Credit" button
    Then I should be redirected to the dashboard
    And I should see the "Show this Credit Type" link for the new credit type
    When I click link "Show this Credit Type"
    Then I should see Delete button
    When I click on Delete button
    Then I should be redirected to Dashboard
    And should see a deletion message