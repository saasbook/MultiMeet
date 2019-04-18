Given("the project named {string} has the following times:") do |project_name, table|
  project = Project.find_by(:project_name => project_name)
  project_id = project[:id]

  table.hashes.each do |row|
    index = ProjectTime.all.count
    project_time = {id: index+1, project_id: project_id, date_time: Time.parse(row[:datetime])}
    ProjectTime.create(project_time)
  end
end
