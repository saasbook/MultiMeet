# frozen_string_literal: true
require 'csv'

class Matching < ActiveRecord::Base
  belongs_to :project
  
  def self.to_csv(json)
      CSV.generate do |csv|
          csv << ['Time', 'Person']
          JSON.parse(json)['schedule'].each do |hash|
              csv << [hash['timestamp'], hash["people_called"].join(', ')]
          end
      end
  end
end

public def people
	people = []
	self.project.participants.each do |participant|
	  row = { "name": participant.email, "match_degree": participant.match_degree }
	  people.push(row)
end

people
end

public def timeslots
	all_project_times = ProjectTime.where(project_id: self.project.id).pluck(:date_time)

	timeslots = []
	all_project_times.each do |timeslot|
	  timeslot_formatted = timeslot.strftime('%Y-%m-%d %H:%M')
	  row = { "timestamp": timeslot_formatted, "tracks": 1 }
	  timeslots.push(row)
	end

	timeslots
end

public def participants_not_matched
	notmatched = ""
    for participant in self.project.participants
      if !self.output_json.include? participant.email
        allmatched = false
        notmatched += participant.email + ", "
      end
    end
    return notmatched[0...-2]
end

public def api_call
    require 'rest-client'

    input = {
      category: category,
      global_settings: global_settings,
      people: self.people,
      timeslots: self.timeslots,
      preferences: self.project.formatted_preferences
    }

    output = RestClient.post('http://api.multi-meet.com:5000/multimatch', input.to_json,
                             content_type: :json, accept: :json).body
    output
end

def category
    'person_to_time'
end

def global_settings
{ "minutes": self.project.duration }
end
