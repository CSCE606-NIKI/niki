Feature: Renew Credits
  Background:
        Given I am logged in as "user@example.com" with password "password123"
        When I visit the dashboard page
        Then I should see the "Summary Credits" page title
        And I should see the "New credit" link
        When I visit the new credit type page
        And I fill in "Name" with "renew_credits"
        And I fill in "Credit limit" with "12"
        And I check "Carry forward"
        And I press "Create Credit type"
        Then I should see "Credit type created successfully."
        When I visit the Add New credit page
         And I fill in the following:
        | Field        | Value       |
        | Credit type  | renew_credits |
        | Date         | 2023-10-11  |
        | Amount       | 26         |
        | Description  | Test credit |
        And I click the "Create Credit" button
        Then I should be redirected to the dashboard
        Then I should see an message "Added Successfully!"

  Scenario: Renewing credits with valid carry-forward amounts
    When I visit the renew credits page
    And I select valid carry-forward amounts
    And I submit the renewal form
    Then I should see a success message for credits renewal

 Scenario: Renewing credits with invalid carry-forward amounts
    When I visit the renew credits page
    And I select invalid carry-forward amounts
    And I submit the renewal form
    Then I should see an error message for credits renewal
