# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

##################
#
# SEED USERS
#
##################

users_list = [
  [ "Armando", "Fox", "afox", "armando@berkeley.edu", "ilove169"],
  [ "Jane", "Doe", "jdoe", "janedoe@average.com", "skrskr"]
]

users_list.each do |first, last, username, email, password|
  User.create(first_name: first, last_name: last, username: username,
              email: email, password_digest: BCrypt::Password.create(password),
              password: password, password_confirmation: password)
end

##################
#
# SEED PROJECTS
#
##################
projects_list = [
  [1, "CS 61A Sections", 2, 60], # jdoe
  [2, "169 Meeting Times", 1, 45], # afox
  [3, "Midterm Grading Sessions", 1, 120], # afox
  [4, "EE 16A Lab Sections", 2, 180] # jdoe
]

projects_list.each do |id, name, user_id, duration|
  Project.create(id: id, project_name: name, user_id: user_id, duration: duration)
end

##################
#
# SEED PARTICIPANTS
#
##################
participants_list = [
    {id: 1, project_id: 1, email: "adnan@berkeley.edu"},
    {id: 2, project_id: 1, email: "awesometa@berkeley.edu"},
    {id: 3, project_id: 1, email: "iteachforlife@berkeley.edu"},
    {id: 4, project_id: 1, email: "jackiechan@berkeley.edu"},
    {id: 5, project_id: 2, email: "bobmarley@gmail.com"},
    {id: 6, project_id: 2, email: "johndoe@hotmail.com"},
    {id: 7, project_id: 2, email: "texasranger@ranch.org"},
    {id: 8, project_id: 2, email: "anju@berkeley.edu"},
]

participants_list.each do |participant|
  Participant.create(participant)
end

##################
#
# SEED PROJECT DATES & TIMES
#
##################

=begin
We store both project dates and times in the project_times table.
To differentiate, we use the boolean flag is_date (default false):
- is_date: True  -> signifies a date
- is_date: False -> signifies a time
=end

project_dates_list = [
  # CS 61A Sections
  {id: 1, project_id: 1, date_time: Date.parse("Dec 1 2019"), is_date: true},
  {id: 2, project_id: 1, date_time: Date.parse("Dec 8 2019"), is_date: true},
  # 169 Meeting Times
  {id: 3, project_id: 2, date_time: Date.parse("May 7 2019"), is_date: true},
  {id: 4, project_id: 2, date_time: Date.parse("May 10 2019"), is_date: true}
]

project_dates_list.each do |project_date|
  ProjectTime.create(project_date)
end

# seed Project Times
project_times_list = [
  # CS 61A Sections Dec 1 2019
  {id: 5, project_id: 1, date_time: Time.parse("Dec 1 2019 10:00 AM")},
  {id: 6, project_id: 1, date_time: Time.parse("Dec 1 2019 1:00 PM")},
  # CS 61A Sections Dec 8 2019
  {id: 7, project_id: 1, date_time: Time.parse("Dec 8 2019 3:00 PM")},
  {id: 8, project_id: 1, date_time: Time.parse("Dec 8 2019 4:00 PM")},
  # 169 Meeting Times May 7 2019
  {id: 9, project_id: 2, date_time: Time.parse("May 7 2019 10:30")},
  {id: 10, project_id: 2, date_time: Time.parse("May 7 2019 1:30")},
  # 169 Meeting Times May 10 2019
  {id: 11, project_id: 2, date_time: Time.parse("May 10 2019 10:30")},
  {id: 12, project_id: 2, date_time: Time.parse("May 10 2019 1:30")}
]

project_times_list.each do |project_time|
  ProjectTime.create(project_time)
end

##################
#
# SEED RANKINGS
#
##################

rankings_list = [
  # CS 61A Sections Dec 1 2019
  # Participant 1: adnan@berkeley.edu
  {participant_id: 1, project_time_id: 5, ranking: 1},
  {participant_id: 1, project_time_id: 6, ranking: 3},
  {participant_id: 1, project_time_id: 7, ranking: 2},
  {participant_id: 1, project_time_id: 8, ranking: 1},
  # Participant 2: awesometa@berkeley.edu
  {participant_id: 2, project_time_id: 5, ranking: 0},
  {participant_id: 2, project_time_id: 6, ranking: 1},
  {participant_id: 2, project_time_id: 7, ranking: 2},
  {participant_id: 2, project_time_id: 8, ranking: 3}
]

rankings_list.each do |ranking|
  Ranking.create(ranking)
end
