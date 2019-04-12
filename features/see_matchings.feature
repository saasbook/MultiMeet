Feature: See Rankings
  
    As an admin,
    So that I can run the matching algorithm and see the results,
    I want to see the ability to see matching results.
    
    Scenario: User tried to view matching while not logged in
        Given no current user
        When I access the matchings page for project "name here"
        Then I should see "Log in to view projects."
        
    Scenario: User tries to view matchings for a project with no matchings yet
        When I access the matchings page for project "name here"
        Then I should see "No matching for this project."

    Scenario: User tries to view matchings for a project that does not exist
        When I access the matchings page for project "nonexistent"
        Then I should see "Project named 'nonexistent' does not exist."
        Then I should see "Click here to edit project."

    Scenario: User tries to view matchings for a project they don't have privileges to see
        When I access the matchings page for project "noprivileges"
        Then I should see "Project named 'noprivileges' does not exist."

    Scenario: User views matchings for a project they do have access to
        When I run the steps for running matchings for project "name here"
        And I access the matchings page for project "name here"
        Then I should see "name here"