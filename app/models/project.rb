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

