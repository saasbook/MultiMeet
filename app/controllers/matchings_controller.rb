class MatchingsController < ApplicationController
  before_action :set_matching_and_project, only: [:show, :edit, :update, :destroy]

  # GET /project/:project_id/matching
  def show
    @proj_exists = !(@project.nil?)
    if @proj_exists
      @permission = current_user.id == @project.user.id
    end
    if @proj_exists and @matching
      @is_matching = true
      @parsed_matching = JSON.parse(@matching.output_json)
    end
  end

  def category
    return "person_to_time"
  end

  def global_settings
    return {"minutes": @project.duration}
  end

  def people
    all_participants_emails = Participant.where(project_id: @project.id).pluck(:email)

    people = []
    for email in all_participants_emails
      row = {"name": email, "match_degree": 1}
      people.push(row)
    end

    return people
  end

  def timeslots
    all_project_times = ProjectTime.where(project_id: @project.id).pluck(:date_time)

    timeslots = []
    for timeslot in all_project_times
      timeslot_formatted = timeslot.utc.strftime('%Y-%m-%d %H:%M %p')
      row = {"timestamp": timeslot_formatted, "tracks": 1}
      timeslots.push(row)
    end

    return timeslots
  end

  def preferences
    all_participants_ids = Participant.where(project: @project.id).pluck(:id)
    all_project_time_ids = ProjectTime.where(project_id: @project.id).pluck(:id)

    preferences = []
    all_participants_ids.each do |participant_id|
      all_project_time_ids.each do |project_time_id|
        person = Participant.find_by(project_id: @project.id)['email']
        timeslot = ProjectTime.find_by(project_id: @project.id)['date_time']
        timeslot_formatted = timeslot.utc.strftime('%Y-%m-%d %H:%M %p')
        rank = Ranking.find_by(participant_id: participant_id, project_time_id: project_time_id)['rank']
        row = {"person_name": person, "timeslot": timeslot_formatted, "rank": rank}
        preferences.push(row)
        end
    end
    return preferences
  end

  def all_submitted_preferences?
    all_participants_ids = Participant.where(project: @project.id).pluck(:id)
    all_project_time_ids = ProjectTime.where(project_id: @project.id).pluck(:id)

    all_participants_ids.each do |participant_id|
      all_project_time_ids.each do |project_time_id|
        if not Ranking.find_by(participant_id: participant_id, project_time_id: project_time_id)['rank'].is_a? Integer
          return false
        end
      end
    end
    return true
  end

  def api
    require 'rest-client'

    input = {
      :category => category,
      :global_settings => global_settings,
      :people => people,
      :timeslots => timeslots,
      :preferences => preferences
    }

    #output = RestClient.post('http://api.multi-meet.com:5000/multimatch', input).body
    output = {
      "schedule": [
          {
              "event_name": rand(36**10).to_s(36),
              "people_called": [
                  "PersonNew"
              ],
              "timestamp": "Fri, 30 Mar 2119 13:00:00 GMT"
          },
          {
              "event_name": "PersonNew1-0",
              "people_called": [
                  "PersonNew2"
              ],
              "timestamp": "Fri, 30 Mar 2119 14:00:00 GMT"
          },
          {
              "event_name": "PersonNew1-0",
              "people_called": [
                  "PersonNew3"
              ],
              "timestamp": "Fri, 30 Mar 2119 15:00:00 GMT"
          }
      ]
    }
    return output.to_json
  end

  # GET /projects/:project_id/matching/new
  def new
    @matching = Matching.new
  end

  # GET /projects/:project_id/matching/edit
  def edit
    respond_to do |format|
      if all_submitted_preferences?
        matching = Matching.where(project_id: @project.id).update_all(output_json: api)
        if @matching.update(matching_params)
          format.html { redirect_to project_matching_path, notice: 'Matching was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # POST /projects/:project_id/matching
  def create
    @matching = Matching.new(matching_params)

    respond_to do |format|
      if @matching.save
        format.html { redirect_to @matching, notice: 'Matching was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /projects/:project_id/matching
  def destroy
    @matching.destroy
    respond_to do |format|
      format.html { redirect_to matchings_url, notice: 'Matching was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matching_and_project
      @matching = Matching.find_by(params.slice(:project_id))
      @project = Project.find_by(:id => params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matching_params
      params.fetch(:matching, {})
    end
end
