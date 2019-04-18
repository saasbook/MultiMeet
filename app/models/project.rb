class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_times
  has_many :participants
  has_many :rankings, through: :participants
end
