Feature: See Rankings
  
    As an admin,
    So that I can run the matching algorithm and see the results,
    I want to see the ability to see matching results.
    
    Scenario: User tried to view matching while not logged in
        Given a user with the email "lawrencechen14@berkeley.edu" with password "password" and with username "lawrencechen14" exists
        And a registered user with the username "lawrencechen14" has a project named "project"
        And no current user
        When I access the matchings page for project "project"
        Then I should see "Permission denied."
        
    Scenario: User tries to view matchings for a project with no matchings yet
        When I access the matchings page for project "name here"
        Then I should see "No matching for this project."

    Scenario: User tries to view matchings for a project that does not exist
        When I access the matchings page for project "5"
        Then I should see "No project by this id exists."

    Scenario: User tries to view matchings for a project they don't have privileges to see
        Given a user with the email "lawrencechen14@berkeley.edu" with password "password" and with username "lawrencechen14" exists
        And a registered user with the username "lawrencechen14" has a project named "project"
        When I access the matchings page for project "project"
        Then I should see "Permission denied."

    Scenario: User views matchings for a project they do have access to
        When I run the steps for running matchings for project "5"
        And I access the matchings page for project "5"
        Then I should see "to be finished"