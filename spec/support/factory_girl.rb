# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  factory :user do
    id 1
    first_name 'Jane'
    last_name  'Doe'
    username 'jdoe'
    email 'janedoe@average.com'
    password 'skrskr'
    password_confirmation 'skrskr'
  end
end

FactoryGirl.define do
  factory :project do
    id 1
    project_name 'CS 61A Sections'
    duration 60
    user_id 1
  end
end
