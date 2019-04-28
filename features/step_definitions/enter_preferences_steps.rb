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
