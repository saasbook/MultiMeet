# frozen_string_literal: true
require 'csv'

class Matching < ActiveRecord::Base
  belongs_to :project
  
  def self.to_csv(json)
      CSV.generate do |csv|
          csv << ['Time', 'Event', 'Person']
          JSON.parse(json)['schedule'].each do |hash|
              csv << [hash['timestamp'], hash['event_name'], hash["people_called"].join(', ')]
          end
      end
  end
end
