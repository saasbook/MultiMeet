Given("the project named {string} has the following participants:") do |project_name, table|
  project = Project.find_by(:project_name => project_name)
  project_id = project[:id]

  table.hashes.each do |row|
    index = Participant.all.count
    participant = {id: index+1, project_id: project_id, email: row[:email]}
    Participant.create(participant)
  end
end
