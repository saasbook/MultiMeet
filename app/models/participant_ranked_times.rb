class ParticipantRankedTimes < ActiveRecord::Base
  belongs_to :participants
  belongs_to :project_times
end
