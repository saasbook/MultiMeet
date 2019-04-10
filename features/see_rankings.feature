Feature: See Rankings
  
    As an admin,
    So that I can run the matching algorithm and see the results,
    I want to see the ability to see matching results.
    
    Scenario: User is not logged in
        Given no current user
        When I access the rankings page for project "name here"
        Then I should be on the login page
        
    Scenario: User tries to view rankings for a project with no rankings yet
        When I access the rankings page for project "name here"
        Then I should see "Project named 'name here' does not have any rankings yet."

    Scenario: User tries to view rankings for a project that does not exist
        When I access the rankings page for project "nonexistent"
        Then I should see "Project named 'nonexistent' does not exist."
        Then I should see "Click here to edit project."

    Scenario: User tries to view rankings for a project they don't have privileges to see
        When I access the rankings page for project "noprivileges"
        Then I should see "Project named 'noprivileges' does not exist."

    Scenario: User views rankings for a project they do have access to
        When I run the steps for running rankings for project "name here"
        And I access the rankings page for project "name here"
        Then I should see "name here"