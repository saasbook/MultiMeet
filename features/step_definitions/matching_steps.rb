# frozen_string_literal: true

Given('{int} people submitted preferences for {string}') do |int, project_name|
  project = Project.find_by(project_name: project_name)
  project_id = project[:id]
  all_participants_ids = Participant.where(project: project_id).pluck(:id)
  all_project_time_ids = ProjectTime.where(project_id: project_id).pluck(:id)

  all_participants_ids[0..int - 1].each do |participant_id|
    all_project_time_ids.each do |project_time_id|
      Ranking.create(participant_id: participant_id, project_time_id: project_time_id, rank: 1)
    end
  end
end
