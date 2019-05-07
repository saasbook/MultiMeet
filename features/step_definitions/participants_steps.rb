# frozen_string_literal: true

Given('the project named {string} has the following participants:') do |project_name, table|
  project = Project.find_by(project_name: project_name)
  project_id = project[:id]

  table.hashes.each do |row|
    index = Participant.all.count
    participant = {id: index+1, project_id: project_id, email: row[:email], last_responded: nil}
    Participant.create(participant)
  end
end

Then "the participant should receive an email" do
  participant = Participant.find(1)
  email = ActionMailer::Base.deliveries.first
  email.from[0].should == "multimeetemailer@gmail.com"
  email.to[0].should == participant.email
  email.body.encoded.should include("Hello, please give me your availability")
end

When /^I visit the link from the email for project of id "(.*)" and participant of id "(.*)"$/ do |project_id, part_id|
  participant = Participant.find(part_id)
  visit "/projects/"+ project_id + "/participants/" + part_id + "/ranking/edit?secret_id=" + participant.secret_id
end

When /^I visit the bad link from the email for project of id "(.*)" and participant of id "(.*)"$/ do |project_id, part_id|
  participant = Participant.find(part_id)
  visit "/projects/"+ project_id + "/participants/" + part_id + "/ranking/edit?secret_id=" + participant.secret_id + "a"
end

When("I update the match degree of {string} to {int}") do |string, int|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("the match degree of {string} should be {int}") do |string, int|
  pending # Write code here that turns the phrase above into concrete actions
end
