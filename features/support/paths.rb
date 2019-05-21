# frozen_string_literal: true

# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the landing\s?page$/
      '/'

    when /^the matchings page for project of id "(.*)"$/
      "/projects/" + $1 + "/matching"

    when /^the times page for "(.*)"$/
      project_times_path(Project.find_by(:project_name => $1))

    when /^the roster page for "(.*)"$/
      project_participants_path(Project.find_by(:project_name => $1))

    when /^the participants page for "(.*)"$/
      project_participants_path(Project.find_by(:project_name => $1))

    when /^the edit page for "(.*)"$/
      edit_project_path(Project.find_by(:project_name => $1))

    when /^the matchings page for "(.*)"$/
      project_matching_path(Project.find_by(project_name: Regexp.last_match(1)))

    when /^the project participants page for "(.*)" for project "(.*)"$/
      project_participant_path(Project.find_by(:project_name => $2),
                               Participant.find_by(:email => $1))

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /^the URL "(.*)"$/
      Regexp.last_match(1)

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = Regexp.last_match(1).split(/\s+/)
        send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
              "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
