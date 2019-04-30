Given /^a participant to project "(.*)" with email "(.*)" has a secretid "(.*)"$/ do |project_name, email, secretid|
  project = Project.find_by(:project_name => project_name)
  project_id = project[:id]

  participant = Participant.find_by(:project_id => project_id, :email => email)

  participant.secret_id = secretid
end

When /^I access the time ranking page for project "(.*)" from email "(.*)" and secretid "(.*)"$/ do |project_name, email, secretid|
	
	project = Project.find_by(:project_name => project_name)
    project_id = project[:id]

    participant = Participant.find_by(:project_id => project_id, :email => email)
    participant_id = participant[:id]    
	
	visit "/projects/" + String(project_id) + "/participants/" + String(participant_id) + "/ranking&secretid=" + secretid 
end

When /^I choose "(.*)" for time "(.*)"$/ do |option, time|
  pending # Write code here that turns the phrase above into concrete actions
  time = ProjectTime.find_by(:date_time => Time.parse(row[:datetime]))
  if option.eql?("Preferred")
    choose(time.id, option: 1) # name and value to make unique
  elsif option.eql?("Okay")
    choose(time.id, option: 2) # name and value to make unique
  else
    choose(time.id, option: 3) # name and value to make unique
  end
end
