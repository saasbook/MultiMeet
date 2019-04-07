class ProjectDate < ActiveRecord::Base
  belongs_to :project
  has_many :participant_time
end
