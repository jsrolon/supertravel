Feature: See plans
  Scenario: Enter plans
    Given I am on the home page
    When I press "Plans"
    Then I should see "New Plan"