Feature: Managing Credits
  Background:
        Given I am logged in as "user@example.com" with password "password123"

  Scenario: Viewing the Credit Index
    When I visit the dashboard page
    Then I should see the "Summary Credits" page title
    And I should see the "Add New Credit" link

  Scenario: Creating a New Credit Successfully
    When I visit the new credit page
    And I fill in the following:
    | Field        | Value       |
    | Credit Type  | Credit_type1 |
    | Date         | 2023-10-11  |
    | Amount       | 100         |
    | Description  | Test credit |
    And I click the "Submit" button
    Then I should be redirected to the dashboard
    And a new credit with type "Credit_type1" and amount "100" should exist in the system

  Scenario: Creating a New Credit with Exceeded Limit
    When I visit the new credit page
      And I fill in the following:
        | Field        | Value       |
        | Credit Type  | Credit_type1 |
        | Date         | 2023-06-11  |
        | Amount       | 300         |
        | Description  | Test credit |
    And I click the "Submit" button
    Then I should see an error message for "Credit_type1"
    And I should not be redirected to the dashboard

  Scenario: Viewing a Credit
    Given there is a credit with type "Credit_type2" in the system
    When I visit the credit page for that credit
    Then I should see the credit details
