# frozen_string_literal: true

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_times
  has_many :participants
  has_many :rankings, through: :participants
  has_one :matching
end


public def formatted_preferences
    preferences = []
    self.rankings.each do |ranking|
      person = ranking.participant.email
      timeslot = ranking.project_time.date_time
      timeslot_formatted = timeslot.strftime('%Y-%m-%d %H:%M')
      if ranking.rank != 0
        row = {"person_name": person, "timeslot": timeslot_formatted, "rank": ranking.rank}
        preferences.push(row)
      end
    end

    preferences
end

public def email_participants (subject, body)
	participants = self.participants
    
    parsed_matching = JSON.parse(self.matching.output_json)
    ParticipantsMailer.set_project_name(self.project_name)

    emails_to_times = {}
    parsed_matching['schedule'].each do |matching|
      email = matching['people_called'][0]
      timestamp = Time.parse(matching["timestamp"]).strftime("%A, %B %d %Y %I:%M %p")

      if !emails_to_times[email]
        emails_to_times[email] = ""
      end
      emails_to_times[email] += timestamp + ", "
    end

    emails_to_times.each do |email, times|
      ParticipantsMailer.matching_email(email, subject, body, times[0...-2]).deliver_now
    end

end