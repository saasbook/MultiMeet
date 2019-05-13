Feature: security

  As a project owner,
  So that my projects are secure,
  I want to be the only one who can access them.

  Background: A project is set up and participants are invited to rank times
    Given a user with the email "lawrencechen14@berkeley.edu" with password "password1" and with username "lawrencechen14" exists
    Given a user with the email "daniellee@berkeley.edu" with password "password2" and with username "daniellee" exists
    And a registered user with the username "lawrencechen14" has a project named "CS169 Sections"
    And a registered user with the username "daniellee" has a project named "CS169 Meetings"
    And I am on the login page
    When I fill in "Email" with "lawrencechen14@berkeley.edu"
    And I fill in "Password" with "password1"
    And I press "Log In"
    And the project named "CS169 Meetings" has the following participants:
      | email                  |
      | person1@berkeley.edu   |
      | person2@berkeley.edu   |

  Scenario: User tries to access another user's project page
    When I access the show page for the project with id "2"
    Then I should see "Access denied."

  Scenario: User tries to edit another user's participants
    When I access the participant edit page for the project with id "1" and participant with id "1"
    Then I should see "Access denied."

