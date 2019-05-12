Feature: Match

  As an admin,
  I want to run the matching algorithm
  So users can be assigned a time

  Background: A project is set up
    Given a registered user with the email "jsluong@berkeley.edu" with username "jsluong" exists
    And I am on the login page
    When I fill in "Email" with "jsluong@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    And a registered user with the username "jsluong" has a project named "CS61A Sections"
    And the project named "CS61A Sections" has the following participants:
    | email                      |
    | alexstennet@berkeley.edu   |
    | andrew.huang@berkeley.edu  |
    | addison.chan@berkeley.edu  |
    | annietang@berkeley.edu     |
    | tperumpail@berkeley.edu    |

    And the project named "CS61A Sections" has the following times:
    | datetime            |
    | Dec 1 2019 10:00 AM |
    | Dec 1 2019 1:00 PM  |
    | Dec 8 2019 3:00 PM  |
    | Dec 8 2019 4:00 PM  |
    | Dec 8 2019 6:00 PM  |
    And I am on the participants page for "CS61A Sections"

  Scenario: User is unable to start a match when not everyone has submitted preferences
    Given I autofill rankings for "alexstennet@berkeley.edu"
    And I autofill rankings for "andrew.huang@berkeley.edu"
    And I autofill rankings for "addison.chan@berkeley.edu"
    When I am on the matchings page for "CS61A Sections"
    Then I should see "Not everyone has submitted preferences."

  Scenario: User runs the algorithm successfully after everyone has submitted preferences and rematches
    Given I autofill rankings for "alexstennet@berkeley.edu"
    And I autofill rankings for "andrew.huang@berkeley.edu"
    And I autofill rankings for "addison.chan@berkeley.edu"
    And I autofill rankings for "annietang@berkeley.edu"
    And I autofill rankings for "tperumpail@berkeley.edu"
    When I am on the matchings page for "CS61A Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61A Sections"
    And I should see "All users successfully matched."
    Then I press "Run algorithm again"
    And I should see "All users successfully matched."

  Scenario: A user sets up a project with no roster
    Given a registered user with the username "jsluong" has a project named "No Participants"
    And I am on the matchings page for "No Participants"
    Then I should see "There are no participants."
    
  Scenario: Download CSV 
    Given 5 people submitted preferences for "CS61A Sections"
    When I am on the matchings page for "CS61A Sections"
    And I press "Match!"
    Then I should see "Download CSV"
    When I follow "Download CSV"
    Then I should get a download with the filename "CS61A Sections_matching.csv"

  Scenario: User runs the algorithm successfully on a single-degree match
    Then the match degree of "alexstennet@berkeley.edu" should be 1
    Then the match degree of "andrew.huang@berkeley.edu" should be 1
    Then the match degree of "addison.chan@berkeley.edu" should be 1
    Then the match degree of "annietang@berkeley.edu" should be 1
    Then the match degree of "tperumpail@berkeley.edu" should be 1
    Given I autofill rankings for "alexstennet@berkeley.edu"
    And I autofill rankings for "andrew.huang@berkeley.edu"
    And I autofill rankings for "addison.chan@berkeley.edu"
    And I autofill rankings for "annietang@berkeley.edu"
    And I autofill rankings for "tperumpail@berkeley.edu"
    And I am on the matchings page for "CS61A Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61A Sections"
    And I should see "All users successfully matched."
    Then I press "Run algorithm again"
    And I should see "All users successfully matched."
    And I should not see "did not receive a match."

  Scenario: User is properly warned when not all users are matched
    Given a registered user with the username "jsluong" has a project named "CS61B Sections"
    And the project named "CS61B Sections" has the following participants:
    | email                      |
    | shidihuang@berkeley.edu   |
    | liangyozhu@berkeley.edu  |

    And the project named "CS61B Sections" has the following times:
    | datetime            |
    | Dec 1 2019 10:00 AM |

    And I am on the participants page for "CS61B Sections"
    Given I autofill rankings for "shidihuang@berkeley.edu"
    And I autofill rankings for "liangyozhu@berkeley.edu"
    When I am on the matchings page for "CS61B Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61B Sections"
    And I should see "Matching Complete."
    Then I press "Run algorithm again"
    And I should see "did not receive a match."

  Scenario: User is not warned when all users are matched
    Given I autofill rankings for "alexstennet@berkeley.edu"
    And I autofill rankings for "andrew.huang@berkeley.edu"
    And I autofill rankings for "addison.chan@berkeley.edu"
    And I autofill rankings for "annietang@berkeley.edu"
    And I autofill rankings for "tperumpail@berkeley.edu"
    When I am on the matchings page for "CS61A Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61A Sections"
    And I should see "Matching Complete."
    Then I press "Run algorithm again"
<<<<<<< HEAD
    And I should see "All users successfully matched."
=======
    And I should see "Matching Complete. All users successfully matched."

   Scenario: User is warned when no users are matched
    Given 5 people submitted negative preferences for "CS61A Sections"
    When I am on the matchings page for "CS61A Sections"
    Then I should see "Ready to match."
    And I press "Match!"
    Then I should be on the matchings page for "CS61A Sections"
    And I should see "Matching Complete."
    Then I press "Run algorithm again"
    And I should see "Matching Complete. addison.chan@berkeley.edu, alexstennet@berkeley.edu, andrew.huang@berkeley.edu, annietang@berkeley.edu, tperumpail@berkeley.edu did not receive a match."
>>>>>>> 1264e4eed76cf24cb4d4b2df3f6596c27c8edc5c
