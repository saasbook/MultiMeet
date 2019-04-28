# frozen_string_literal: true

Given('the project named {string} has the following participants:') do |project_name, table|
  project = Project.find_by(project_name: project_name)
  project_id = project[:id]

  table.hashes.each do |row|
    index = Participant.all.count
    participant = { id: index + 1, project_id: project_id, email: row[:email] }
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