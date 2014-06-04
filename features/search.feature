Feature: See events
  Scenario: Enter event
    Given I am on the home page
    When I fill in "q" with "Paris"
    Then I should see "Wait"