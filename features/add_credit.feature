Feature: Managing Credits
  Background:
      Given I am logged in as "user@example.com" with password "password123"
      And I have created a credit type "type1"

  Scenario: Viewing the Credit Index

    When I visit the dashboard page
    Then I should see the "Summary Credits" page title
    And I should see the "New credit" link

  Scenario: Creating a New Credit Successfully
    When I visit the Add New credit page
    And I fill in the following:
    | Field        | Value       |
    | Credit type  | type1       |
    | Date         | 2023-10-11  |
    | Amount       | 100         |
    | Description  | Test credit |
    And I click the "Create Credit" button
    Then I should be redirected to the dashboard
    Then I should see an message "Added Successfully!"

  Scenario: Creating a New Credit with Exceeded Limit
    When I visit the Add New credit page
      And I fill in the following:
        | Field        | Value       |
        | Credit type  | type1       |
        | Date         | 2023-06-11  |
        | Amount       | 1500        |
        | Description  | Test credit |
    And I click the "Create Credit" button
    Then I should be redirected to the dashboard
    Then I should see an message "Added Successfully!"


  Scenario: Creating a New Credit with Invalid Inputs
    When I visit the Add New credit page
      And I fill in the following:
        | Field        | Value       |
        | Credit type  | type1       | 
        | Amount       | 10          |
        | Description  | Test credit |
    And I click the "Create Credit" button
    Then I should see an error message for "Couldn't be added, try again!"
    And I should not be redirected to the dashboard

  Scenario: Viewing a Credit
    Given there is a credit with type "type1" in the system
    When I visit the credit page for that credit
    Then I should see the credit details

  # Scenario: CRUD operations on the credit
  #   Given I am on Add New credit page
  #   And I fill in the following:
  #     | Field        | Value       |
  #     | Credit type  | type1       |
  #     | Date         | 2023-06-11  |
  #     | Amount       | 50          |
  #     | Description  | Test credit |
  #   And I click the "Create Credit" button
  #   When I click the "Show this credit" link for the first credit
  #   Then I should be redirected to show this credit path
  #   And I should see the credit details on the page
  #   When I click on "Edit credit" button
  #   Then I should be redirected to edit credit page
  #   When I click the "Show this credit" link button
  #   When I click on the button "Delete credit" to delete
  #   Then I should be redirected to the dashboard
  #   And this credit shouldnot be there


