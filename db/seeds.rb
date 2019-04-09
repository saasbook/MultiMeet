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
  [1, "CS 61A Sections", "jdoe", 60],
  [2, "169 Meeting Times", "afox", 45],
  [3, "Midterm Grading Sessions", "asfox", 120],
  [4, "EE 16A Lab Sections", "jdoe", 180]
]

projects_list.each do |id, name, username, duration|
  Project.create(id: id, project_name: name, username: username, duration: duration)
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
example usage of joining project dates and times:

Kevin@kevintekiair MultiMeet-1 (kevin/models-sample-data) $ rake db:seed
Kevin@kevintekiair MultiMeet-1 (kevin/models-sample-data) $ rails db
SQLite version 3.13.0 2016-05-18 10:57:30
Enter ".help" for usage hints.
sqlite> select project_id, start_time from project_dates
   ...> join project_times
   ...> on project_dates.id = project_times.project_date_id;
1|2019-12-01 18:00:00.000000
1|2019-12-01 21:00:00.000000
1|2019-12-08 23:00:00.000000
1|2019-12-09 00:00:00.000000
2|2019-05-07 17:30:00.000000
2|2019-05-07 08:30:00.000000
2|2019-05-10 17:30:00.000000
2|2019-05-10 08:30:00.000000
=end

project_dates_list = [
  # CS 61A Sections
  {id: 1, project_id: 1, date: Date.parse("Dec 1 2019")},
  {id: 2, project_id: 1, date: Date.parse("Dec 8 2019")},
  # 169 Meeting Times
  {id: 3, project_id: 2, date: Date.parse("May 7 2019")},
  {id: 4, project_id: 2, date: Date.parse("May 10 2019")}
]

project_dates_list.each do |project_date|
  ProjectDate.create(project_date)
end

# seed Project Times
project_times_list = [
  # CS 61A Sections Dec 1 2019
  {id: 1, project_date_id: 1, start_time: Time.parse("Dec 1 2019 10:00 AM")},
  {id: 2, project_date_id: 1, start_time: Time.parse("Dec 1 2019 1:00 PM")},
  # CS 61A Sections Dec 8 2019
  {id: 3, project_date_id: 2, start_time: Time.parse("Dec 8 2019 3:00 PM")},
  {id: 4, project_date_id: 2, start_time: Time.parse("Dec 8 2019 4:00 PM")},
  # 169 Meeting Times May 7 2019
  {id: 5, project_date_id: 3, start_time: Time.parse("May 7 2019 10:30")},
  {id: 6, project_date_id: 3, start_time: Time.parse("May 7 2019 1:30")},
  # 169 Meeting Times May 10 2019
  {id: 7, project_date_id: 4, start_time: Time.parse("May 10 2019 10:30")},
  {id: 8, project_date_id: 4, start_time: Time.parse("May 10 2019 1:30")}
]

project_times_list.each do |project_time|
  ProjectTime.create(project_time)
end

##################
#
# SEED PARTICIPANT RANKINGS
#
##################

project_rankings_list = [
  # CS 61A Sections Dec 1 2019
  # Participant 1: adnan@berkeley.edu
  {participant_id: 1, project_time_id: 1, ranking: 1},
  {participant_id: 1, project_time_id: 2, ranking: 3},
  {participant_id: 1, project_time_id: 3, ranking: 2},
  {participant_id: 1, project_time_id: 4, ranking: 1},
  # Participant 2: awesometa@berkeley.edu
  {participant_id: 2, project_time_id: 1, ranking: 0},
  {participant_id: 2, project_time_id: 2, ranking: 1},
  {participant_id: 2, project_time_id: 3, ranking: 2},
  {participant_id: 2, project_time_id: 4, ranking: 3}
]

project_rankings_list.each do |ranking|
  ParticipantRankedTime.create(ranking)
end
