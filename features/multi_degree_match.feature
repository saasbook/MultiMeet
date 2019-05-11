Feature: Multi-degree Matching

  As a project owner,
  So that I can match multiple times to each participant,
  I want to have the option to do so.

  Background: A project is set up
    Given a registered user with the email "jsluong@berkeley.edu" with username "jsluong" exists
    And I am on the login page
    When I fill in "Email" with "jsluong@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    And a registered user with the username "jsluong" has a project named "CS61A Sections"

    And the project named "CS61A Sections" has the following times:
    | datetime            |
    | Dec 1 2019 10:00 AM |
    | Dec 1 2019 1:00 PM  |
    | Dec 8 2019 3:00 PM  |
    | Dec 8 2019 4:00 PM  |

    And I am on the participants page for "CS61A Sections"

  Scenario: User sets match degree while adding participants for the first time
    When I fill in "Email" with "alexstennet@berkeley.edu"
    And I fill in "Match Degree" with "2"
    And press "Add New Participant"
    When I fill in "Email" with "andrew.huang@berkeley.edu"
    And I fill in "Match Degree" with "2"
    And press "Add New Participant"
    When I fill in "Email" with "addison.chan@berkeley.edu"
    And I fill in "Match Degree" with "1"
    And press "Add New Participant"
    When I fill in "Email" with "annietang@berkeley.edu"
    And press "Add New Participant"
    Then the match degree of "alexstennet@berkeley.edu" should be 2
    Then the match degree of "andrew.huang@berkeley.edu" should be 2
    Then the match degree of "addison.chan@berkeley.edu" should be 1
    Then the match degree of "annietang@berkeley.edu" should be 1
    When 4 people submitted preferences for "CS61A Sections"
    And I am on the matchings page for "CS61A Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61A Sections"
    And I should see "Successfully matched."
    Then I press "Run algorithm again"
    And I should see "Successfully matched."

  Scenario: User edits match degree manually via participants page
    When the project named "CS61A Sections" has the following participants:
    | email                      |
    | alexstennet@berkeley.edu   |
    | andrew.huang@berkeley.edu  |
    | addison.chan@berkeley.edu  |
    | annietang@berkeley.edu     |

    And I am on the participants page for "CS61A Sections"
    Then the match degree of "alexstennet@berkeley.edu" should be 1
    Then the match degree of "andrew.huang@berkeley.edu" should be 1
    Then the match degree of "addison.chan@berkeley.edu" should be 1
    Then the match degree of "annietang@berkeley.edu" should be 1

    Then I am on the project participants page for "alexstennet@berkeley.edu" for project "CS61A Sections"
    And I fill in "Match Degree" with "2"
    And I press "Update Participant"
    Then I should see "Participant was successfully updated."
    Then I am on the participants page for "CS61A Sections"
    And the match degree of "alexstennet@berkeley.edu" should be 2

    When 4 people submitted preferences for "CS61A Sections"
    And I am on the matchings page for "CS61A Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61A Sections"
    And I should see "Successfully matched."
    Then I press "Run algorithm again"
    And I should see "Successfully matched."

  Scenario: User runs the algorithm successfully on a single-degree match
    When the project named "CS61A Sections" has the following participants:
    | email                      |
    | alexstennet@berkeley.edu   |
    | andrew.huang@berkeley.edu  |
    | addison.chan@berkeley.edu  |
    | annietang@berkeley.edu     |

    And I am on the participants page for "CS61A Sections"
    Then the match degree of "alexstennet@berkeley.edu" should be 1
    Then the match degree of "andrew.huang@berkeley.edu" should be 1
    Then the match degree of "addison.chan@berkeley.edu" should be 1
    Then the match degree of "annietang@berkeley.edu" should be 1
    When 5 people submitted preferences for "CS61A Sections"
    And I am on the matchings page for "CS61A Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61A Sections"
    And I should see "Successfully matched."
    Then I press "Run algorithm again"
    And I should see "Successfully matched."
