Feature: participants can enter preferences

As a participant,
So that I can select which times I like and get the times I want,
I want to be able to rank the times.

Background: A project is set up and participants are invited to rank times
    Given a registered user with the email "raichu@berkeley.edu" with username "raichu" exists
    And a registered user with the username "raichu" has a project named "CS169 Sections"
    And the project named "CS169 Sections" has the following participants:
    | email                  |
    | empoleon@berkeley.edu  |
    | charizard@berkeley.edu |

    And the project named "CS169 Sections" has the following times:
    | datetime               |
    | Dec 1 2019 10:00 AM    |
    | Dec 1 2019 1:00 PM     |

    And all participants for project "CS169 Sections" have been sent email links to rank their times


  Scenario: User enters their preferences for times

  Scenario: User attempts to enter preferences for times for a project that they are not a part of

  Scenario: User attempts to enter preferences before being invited to

  Scenario: User attempts to enter preferences for times for a project that does not exist

  Scenario: User submits without filling out all of the preferences
