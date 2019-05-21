# frozen_string_literal: true

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

Then /^I should get a download with the filename "([^\"]*)"$/ do |filename|
  page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end