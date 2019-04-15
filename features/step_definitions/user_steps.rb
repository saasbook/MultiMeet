Given /^no current user$/ do
    page.driver.submit :delete, "/logout", {}
end

Given /^a registered user with the email "(.*)" with username "(.*)" exists$/ do |email, username|
    User.create(:username => username, :email => email, :first_name => "Daniel",
    :last_name => "Lee", :password => "password", :password_confirmation => "password")
end

Given /^a registered user with the email "(.*)" with password "(.*)" exists$/ do |email, password|
    User.create(:username => "ddd", :email => email, :first_name => "Daniel",
    :last_name => "Lee", :password => password, :password_confirmation => password)
end

Given /^a user with the email "(.*)" with password "(.*)" and with username "(.*)" exists$/ do |email, password, username|
    User.create(:username => username, :email => email, :first_name => "Daniel",
                :last_name => "Lee", :password => password, :password_confirmation => password)
end

Given /^a registered user with the username "(.*)" has a project named "(.*)"$/ do |username, project_name|
  user = User.find_by(:username => username)
  user.projects.create(:project_name => project_name)
end

When /^I access the landing page$/ do
    get "/"
end

When /^I access the matchings page for project of id "(.*)"$/ do |id|
    visit "/projects/" + id + "/matching"
    
end


Given /^a default matching exists for project with id "(.*)"$/ do |id|
      multimatch_121_output = {
        "schedule": [
            {
                "event_name": "Person3-0",
                "people_called": [
                    "Person3"
                ],
                "timestamp": "Fri, 22 Mar 2019 13:00:00 GMT"
            },
            {
                "event_name": "Person1-0",
                "people_called": [
                    "Person1"
                ],
                "timestamp": "Fri, 22 Mar 2019 14:00:00 GMT"
            },
            {
                "event_name": "Person2-0",
                "people_called": [
                    "Person2"
                ],
                "timestamp": "Fri, 22 Mar 2019 15:00:00 GMT"
            }
        ]
    }
    Matching.create(project_id: id, output_json: multimatch_121_output.to_json)
  
end
