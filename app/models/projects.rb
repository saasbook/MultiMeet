class Projects < ActiveRecord::Base
  belongs_to :users
  has_many :project_times
end
