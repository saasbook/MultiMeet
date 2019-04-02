class Participants < ActiveRecord::Base
  belongs_to :projects
  has_many :participant_ranked_times
end
