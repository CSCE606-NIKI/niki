# features/credit_mailer.feature

Feature: Credit Mailer

  Scenario: Verify the content of the credit mailer template
    Given a user with username "John Doe" and email "user@example.com" and password "password123" and renewal date "2023-12-01"
    When the credit mailer is generated
    Then the email should contain:
      """
      Dear John Doe,
      I hope this email finds you well.
      Your renewal date is approaching: 2023-12-01
      You currently have 10 pending credits for this renewal period. Take action now to ensure a smooth renewal process.
      Here's a quick summary of your credits
      Credits Pending for ExampleCreditType
      Thank you for your attention.
      """
