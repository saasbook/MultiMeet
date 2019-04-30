Given /^a participant to project "(.*)" with email "(.*)" has a secret_id "(.*)"$/ do |project_name, email, secret_id|
  project = Project.find_by(:project_name => project_name)
  participant = Participant.find_by(:project_id => project.id, :email => email)
  participant.update(secret_id: secret_id)
end

When /^I access the time ranking page for project "(.*)" from email "(.*)" and secret_id "(.*)"$/ do |project_name, email, secret_id|
  project = Project.find_by(:project_name => project_name)
  participant = Participant.find_by(:project_id => project.id, :email => email)
  visit "/projects/" + project.id.to_s + "/participants/" + participant.id.to_s + "/ranking/edit?secret_id=" + secret_id
end

When /^I access the time ranking page for project of id "(.*)" from user id "(.*)" and secret_id "(.*)"$/ do |project_id, user_id, secret_id|
  visit "/projects/" + project_id.to_s + "/participants/" + user_id.to_s + "/ranking/edit?secret_id=" + secret_id
end

When /^I choose "(.*)" for time "(.*)"$/ do |option, time|
  time = ProjectTime.find_by(:date_time => Time.parse(time))
  if option.eql?("Preferred")
    choose(time.id.to_s, option: "1") # name and value to make unique
  elsif option.eql?("Okay")
    choose(time.id.to_s, option: "2") # name and value to make unique
  else
    choose(time.id.to_s, option: "3") # name and value to make unique
  end
end
