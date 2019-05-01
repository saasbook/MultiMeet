# frozen_string_literal: true

Given('{int} people submitted preferences for {string}') do |int, project_name|
  project = Project.find_by(project_name: project_name)
  project_id = project[:id]
  all_participants_ids = Participant.where(project: project_id).pluck(:id)
  all_project_time_ids = ProjectTime.where(project_id: project_id).pluck(:id)

  start_rank = 2 # first participant ranks first project_time the highest
  all_participants_ids[0..int - 1].each do |participant_id|
    i = start_rank
    all_project_time_ids.each do |project_time_id|
      ranking = Ranking.find_by(participant_id: participant_id, project_time_id: project_time_id)
      if ranking
        ranking.update(rank: i + 1)
      else
        Ranking.create(participant_id: participant_id, project_time_id: project_time_id, rank: i + 1)
      end
      i = (i + 1) % 3
    end
    start_rank = (start_rank + 1) % 3
    participant = Participant.find_by(id: participant_id)
    participant.update(last_responded: Time.now.getutc)
  end
end

Given('the project named {string} has a two-person matching') do |project_name|
  project = Project.find_by(project_name: project_name)
  project_id = project[:id]
  matching = Matching.new(:project_id => project_id)

  matching.output_json = {
    "schedule": [
      {
        "event_name": 'section1',
        "people_called": [
          'nobodyhere@berkeley.edu'
        ],
        "timestamp": 'Dec 1 2019 10:00 AM'
      },
      {
        "event_name": 'section2',
        "people_called": [
          'plsdontemailme@berkeley.edu'
        ],
        "timestamp": 'Dec 1 2019 1:00 PM'
      }
    ]
  }.to_json

  matching.save!
end
