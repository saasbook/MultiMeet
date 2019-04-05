class ProjectTime < ActiveRecord::Base
  belongs_to :project_date
  has_many :participant_ranked_time
end
