Feature: Signup
  
    As a new user
    I want to signup for an account
    So that I can use MultiMeet
    
    Scenario: Reach signup from landing page
        Given no current user
        When I access the landing page
        And I follow "signup"
        Then I should be on the signup page
        
    Scenario: User enters wrong confirm password
        Given I am on the signup page
        And I fill in "First Name" with "Daniel"
        And I fill in "Last Name" with "Lee"
        And I fill in "Username" with "daniel908908"
        And I fill in "Password" with "password"
        And I fill in "Confirm Password" with "passw0rd"
        And I press "Sign Up!"
        Then I should see "Password confirmation doesn't match Password"
    
    Scenario: User successfully completes signup and redirects to project page
        Given I am on the signup page
        And I fill in "First Name" with "Daniel"
        And I fill in "Last Name" with "Lee"
        And I fill in "Username" with "daniel"
        And I fill in "Email" with "daniel@berkeley.edu"
        And I fill in "Password" with "password"
        And I fill in "Confirm Password" with "password"
        And I press "Sign Up!"
        Then I should be on the projects page
        And I should see "Welcome to MultiMeet"
        And I should see "Log Out"
        And I should not see "Log In"
        And I should not see "Sign Up"
    
    Scenario: User enters username or email that are already taken
        Given a registered user with the email "daniellee0228@berkeley.edu" with username "daniel908908" exists
        And I am on the signup page
        And I fill in "First Name" with "Daniel"
        And I fill in "Last Name" with "Lee"
        And I fill in "Username" with "daniel908908"
        And I fill in "Email" with "daniellee0228@berkeley.edu"
        And I fill in "Password" with "password"
        And I fill in "Confirm Password" with "password"
        And I press "Sign Up!"
        Then I should see "Username has already been taken"
        Then I should see "Email has already been taken"
    
    