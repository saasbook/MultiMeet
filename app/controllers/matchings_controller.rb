# frozen_string_literal: true

class MatchingsController < ApplicationController
  before_action :set_instance_variables, only: [:show, :edit, :update, :destroy, :email]

  # GET /project/:project_id/matching
  def show
    unless logged_in?
      require_user
      return
    end

    @proj_exists = !(@project.nil?)
    if @proj_exists
      @permission = current_user.id == @project.user.id
    end

    if @proj_exists and @matching
      @parsed_matching = JSON.parse(@matching.output_json)
      print(@parsed_matching)
    elsif @proj_exists
      @participants_are_set = @all_participants_ids.size > 0
      @times_are_set = @all_participants_ids.size > 0
      @all_submitted_preferences = all_submitted_preferences?
    end
  end

  def email
    @project = Project.find(params[:project_id])
    @participants = @project.participants
    @email_subject = params[:email_subject]
    @email_body = params[:email_body]
    @parsed_matching = JSON.parse(@matching.output_json)
    ParticipantsMailer.set_project_name(@project.project_name)

    @parsed_matching['schedule'].each do |matching|
      ParticipantsMailer.matching_email(
          matching['people_called'][0], @email_subject, @email_body, matching['timestamp']).deliver_now
    end

    flash[:success] = 'Emails have been sent.'
    redirect_to project_matching_path(params[:project_id])
  end

  # GET /projects/:project_id/matching/new
  # def new
  #   @matching = Matching.new
  # end

  # TODO: convert to a PUT/ UPDATE
  # GET /projects/:project_id/matching/edit

  # def edit
  #   respond_to do |format|
  #     if all_submitted_preferences?
  #       #matching = Matching.where(project_id: @project.id).update_all(output_json: api)
  #       if @matching.update(output_json: api)
  #         flash[:success] = 'Successfully matched.'
  #         format.html { redirect_to project_matching_path }
  #       # else
  #       #   format.html { render :edit }
  #       end
  #     end
  #   end
  # end

  # POST /projects/:project_id/matching
  def create
    @project = Project.find_by(id: params[:project_id])
    @matching = @project.matching || Matching.new(project_id: @project.id)
    @matching.output_json = api

    respond_to do |format|
      if @matching.save!
        flash[:success] = 'Successfully matched.'
        format.html { redirect_to project_matching_path }
        # else
        #   format.html { render :new }
      end
    end
  end

  # DELETE /projects/:project_id/matching
  # def destroy
  #   @matching.destroy
  #   respond_to do |format|
  #     flash[:success] = 'Matching was successfully destroyed.'
  #     format.html { redirect_to matchings_url }
  #   end
  # end

  def category
    'person_to_time'
  end

  def global_settings
    { "minutes": @project.duration }
  end

  def people
    people = []
    @project.participants.each do |participant|
      row = { "name": participant.email, "match_degree": participant.match_degree }
      people.push(row)
    end

    people
  end

  def timeslots
    all_project_times = ProjectTime.where(project_id: @project.id).pluck(:date_time)

    timeslots = []
    all_project_times.each do |timeslot|
      timeslot_formatted = timeslot.strftime('%Y-%m-%d %H:%M')
      row = { "timestamp": timeslot_formatted, "tracks": 1 }
      timeslots.push(row)
    end

    timeslots
  end

  def preferences
    preferences = []
    @project.rankings.each do |ranking|
      person = ranking.participant.email
      timeslot = ranking.project_time.date_time
      timeslot_formatted = timeslot.strftime('%Y-%m-%d %H:%M')
      row = {"person_name": person, "timeslot": timeslot_formatted, "rank": ranking.rank}
      preferences.push(row)
    end

    preferences
  end

  def all_submitted_preferences?
    @all_participants_ids.each do |participant_id|
      unless Participant.find_by(id: participant_id).last_responded
        return false
      end
    end
    true
  end

  def api
    require 'rest-client'

    input = {
      category: category,
      global_settings: global_settings,
      people: people,
      timeslots: timeslots,
      preferences: preferences
    }

    output = RestClient.post('http://api.multi-meet.com:5000/multimatch', input.to_json,
                             content_type: :json, accept: :json).body
    output
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance_variables
      @matching = Matching.find_by(params.slice(:project_id))
      @project = Project.find_by(:id => params[:project_id])

      if @project
        @all_participants_ids = @project.participants.pluck(:id)
        @all_project_time_ids = @project.project_times.pluck(:id)
      end
    end

  # Use callbacks to share common setup or constraints between actions.
  def set_matching_and_project
    @matching = Matching.find_by(params.slice(:project_id))
    @project = Project.find_by(id: params[:project_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def matching_params
    params.require(:project_id)
  end
end
