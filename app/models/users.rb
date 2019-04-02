class Users < ActiveRecord::Base
  has_many :projects
end
