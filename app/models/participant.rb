# frozen_string_literal: true

class Participant < ActiveRecord::Base
  belongs_to :project
  has_secure_token :secret_id
  has_many :rankings
end
