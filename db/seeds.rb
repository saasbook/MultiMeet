# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

##################
#
# SEED USERS
#
##################

users_list = [
  ['Armando', 'Fox', 'afox', 'armando@berkeley.edu', 'ilove169'],
  ['Jane', 'Doe', 'jdoe', 'janedoe@average.com', 'skrskr']
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
  [1, 'CS 61A Sections', 2, 60], # jdoe
  [2, '169 Meeting Times', 1, 45], # afox
  [3, 'Midterm Grading Sessions', 1, 120], # afox
  [4, 'EE 16A Lab Sections', 2, 180], # jdoe
  [5, 'multimatch-121', 1, 30] # afox (for testing API)
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
    # CS 61A Sections
    {id: 1, project_id: 1, email: "adnan@berkeley.edu", last_responded: Time.parse("Dec 1 2019 10:00 AM"), match_degree: 1},
    {id: 2, project_id: 1, email: "awesometa@berkeley.edu", last_responded: Time.parse("Dec 2 2019 10:00 AM"), match_degree: 1},
    {id: 3, project_id: 1, email: "iteachforlife@berkeley.edu", last_responded: nil, match_degree: 1},
    {id: 4, project_id: 1, email: "jackiechan@berkeley.edu", last_responded: Time.parse("Dec 4 2019 10:00 AM"), match_degree: 1},
    # 169 Meeting Times
    {id: 5, project_id: 2, email: "bobmarley@gmail.com", last_responded: Time.parse("Dec 5 2019 10:00 AM"), match_degree: 1},
    {id: 6, project_id: 2, email: "johndoe@hotmail.com", last_responded: nil, match_degree: 1},
    {id: 7, project_id: 2, email: "texasranger@ranch.org", last_responded: nil, match_degree: 1},
    {id: 8, project_id: 2, email: "anju@berkeley.edu", last_responded: Time.parse("Dec 8 2019 10:00 AM"), match_degree: 1},
    # multimatch-121
    {id: 9, project_id: 5, email: "person1@gmail.com", last_responded: Time.parse("Dec 9 2019 10:00 AM"), match_degree: 1},
    {id: 10, project_id: 5, email: "person2@gmail.com", last_responded: Time.parse("Dec 10 2019 10:00 AM"), match_degree: 1},
    {id: 11, project_id: 5, email: "person3@gmail.com", last_responded: Time.parse("Dec 11 2019 10:00 AM"), match_degree: 1}
]

participants_list.each do |participant|
  Participant.create(participant)
end

##################
#
# SEED PROJECT DATES & TIMES
#
##################

# We store both project dates and times in the project_times table.
# To differentiate, we use the boolean flag is_date (default false):
# - is_date: True  -> signifies a date
# - is_date: False -> signifies a time

project_dates_list = [
  # CS 61A Sections
  { id: 1, project_id: 1, date_time: Date.parse('Dec 1 2019'), is_date: true },
  { id: 2, project_id: 1, date_time: Date.parse('Dec 8 2019'), is_date: true },
  # 169 Meeting Times
  { id: 3, project_id: 2, date_time: Date.parse('May 7 2019'), is_date: true },
  { id: 4, project_id: 2, date_time: Date.parse('May 10 2019'), is_date: true }
]

project_dates_list.each do |project_date|
  ProjectTime.create(project_date)
end

# seed Project Times
project_times_list = [
  # CS 61A Sections
  { id: 5, project_id: 1, date_time: Time.parse('Dec 1 2019 10:00 AM') },
  { id: 6, project_id: 1, date_time: Time.parse('Dec 1 2019 1:00 PM') },
  { id: 7, project_id: 1, date_time: Time.parse('Dec 8 2019 3:00 PM') },
  { id: 8, project_id: 1, date_time: Time.parse('Dec 8 2019 4:00 PM') },
  # 169 Meeting Times
  { id: 9, project_id: 2, date_time: Time.parse('May 7 2019 10:30 AM') },
  { id: 10, project_id: 2, date_time: Time.parse('May 7 2019 1:30 PM') },
  { id: 11, project_id: 2, date_time: Time.parse('May 10 2019 10:30 PM') },
  { id: 12, project_id: 2, date_time: Time.parse('May 10 2019 1:30 AM') },
  # multimatch-121
  { id: 13, project_id: 5, date_time: Time.parse('2019-03-22 13:00 PM') },
  { id: 14, project_id: 5, date_time: Time.parse('2019-03-22 14:00 PM') },
  { id: 15, project_id: 5, date_time: Time.parse('2019-03-22 15:00 PM') }
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
  { participant_id: 1, project_time_id: 5, rank: 1 },
  { participant_id: 1, project_time_id: 6, rank: 3 },
  { participant_id: 1, project_time_id: 7, rank: 2 },
  { participant_id: 1, project_time_id: 8, rank: 1 },
  # Participant 2: awesometa@berkeley.edu
  { participant_id: 2, project_time_id: 5, rank: 0 },
  { participant_id: 2, project_time_id: 6, rank: 1 },
  { participant_id: 2, project_time_id: 7, rank: 2 },
  { participant_id: 2, project_time_id: 8, rank: 3 },
  # multimatch-121
  { participant_id: 9, project_time_id: 14, rank: 1 },
  { participant_id: 9, project_time_id: 15, rank: 2 },
  { participant_id: 9, project_time_id: 13, rank: 3 },
  { participant_id: 10, project_time_id: 13, rank: 1 },
  { participant_id: 10, project_time_id: 15, rank: 2 },
  { participant_id: 10, project_time_id: 14, rank: 3 },
  { participant_id: 11, project_time_id: 13, rank: 1 },
  { participant_id: 11, project_time_id: 14, rank: 2 },
  { participant_id: 11, project_time_id: 15, rank: 3 }
]

rankings_list.each do |ranking|
  Ranking.create(ranking)
end

##################
#
# SEED MATCHINGS
#
##################

#  - output_json is a string that stores the result returned
#    from calling the MultiMatch api endpoint.

multimatch_121_output = {
  "schedule": [
    {
      "event_name": 'Person3-0',
      "people_called": [
        'Person3'
      ],
      "timestamp": 'Fri, 22 Mar 2019 13:00:00 GMT'
    },
    {
      "event_name": 'Person1-0',
      "people_called": [
        'Person1'
      ],
      "timestamp": 'Fri, 22 Mar 2019 14:00:00 GMT'
    },
    {
      "event_name": 'Person2-0',
      "people_called": [
        'Person2'
      ],
      "timestamp": 'Fri, 22 Mar 2019 15:00:00 GMT'
    }
  ]
}

matchings_list = [
  { project_id: 5, output_json: multimatch_121_output.to_json }
]

matchings_list.each do |matching|
  Matching.create(matching)
end
