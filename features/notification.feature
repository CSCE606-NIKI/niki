Feature: Testing Credits Notification Container
  Scenario: Check Credits Notification Container
        Given I am logged in as "user@example.com" with password "password123"
        When I visit the dashboard page
        Then I should see the "Summary Credits" page title
        And I should see the "New credit" link
        When I visit the Add New credit page
        And I fill in the following:
        | Field        | Value       |
        | Credit Type  | Credit_type1 |
        | Date         | 2023-10-11  |
        | Amount       | 100         |
        | Description  | Test credit |
        And I click the "Create Credit" button
        Then I should be redirected to the dashboard
        And a new credit with type "Credit_type1" and amount "100" should exist in the system

        When I click the bell icon
        Then I should see a button with the text "1 Credits due soon!"
        And I click the button
        Then I should see a dropdown menu
        And I should see 1 credit descriptions

  Scenario: Check Credits Notification Container with no credits
    When I have no credits due soon
    And I should not see the button
    And I should not see a dropdown menu

