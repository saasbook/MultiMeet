# frozen_string_literal: true

class Ranking < ActiveRecord::Base
  belongs_to :participant
  belongs_to :project_time
end
