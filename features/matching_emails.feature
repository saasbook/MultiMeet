Feature: Match

  As an admin,
  I want to run the matching algorithm
  So users can be assigned a time

  Background: A project is set up and matchings exist
    Given a registered user with the email "kevinchien@berkeley.edu" with username "kev-chien" exists
    And I am on the login page
    When I fill in "Email" with "kevinchien@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    And a registered user with the username "kev-chien" has a project named "CS61A Sections"
    And the project named "CS61A Sections" has the following participants:
    | email |
    | nobodyhere@berkeley.edu |
    | plsdontemailme@berkeley.edu |

    And the project named "CS61A Sections" has the following times:
      | datetime            |
      | Dec 1 2019 10:00 AM |
      | Dec 1 2019 1:00 PM  |

    Given 2 people submitted preferences for "CS61A Sections"

    And the project named "CS61A Sections" has a two-person matching

    Then I access the matchings page for project of id "1"


  Scenario: successfully email matchings
    And I fill in "email_body" with "Hello, your final matching has been assigned!"
    And I press "Send email to participants"
    Then the user "nobodyhere@berkeley.edu" should receive a matching email with the correct timestamp "Dec 1 2019 10:00 AM"
    Then I should see "Emails have been sent."
