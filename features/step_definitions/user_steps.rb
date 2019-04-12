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
