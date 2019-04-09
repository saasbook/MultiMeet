Given /^no current user$/ do
    page.driver.submit :delete, "/logout", {}
end

Given /^a registered user with the email "(.*)" with username "(.*)" exists$/ do |email, username|
    user = User.create(:username => username, :email => email, :first_name => "Daniel",
    :last_name => "Lee", :password => "password", :password_confirmation => "password")
end

Given /^a registered user with the email "(.*)" with password "(.*)" exists$/ do |email, password|
    user = User.create(:username => "ddd", :email => email, :first_name => "Daniel",
    :last_name => "Lee", :password => password, :password_confirmation => password)
end


When /^I access the landing page$/ do
    get "/"
end
