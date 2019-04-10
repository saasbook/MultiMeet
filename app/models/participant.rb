class Participant < ActiveRecord::Base
  belongs_to :project
  has_many :rankings
end
