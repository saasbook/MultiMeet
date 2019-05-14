# frozen_string_literal: true

class MatchingsController < ApplicationController
  before_action :set_instance_variables, only: [:show, :edit, :update, :destroy, :email, :modify]

  def set_show_variables
    @proj_exists = !(@project.nil?)
    if @proj_exists
      @permission = current_user.id == @project.user.id
    end

    if @proj_exists and @matching
      @parsed_matching = JSON.parse(@matching.output_json)

    elsif @proj_exists
      @all_submitted_preferences = all_submitted_preferences?
    end

    respond_to do |format|
      format.html
      format.csv {send_data Matching.to_csv(@matching.output_json), :filename => @project.project_name + "_matching.csv"}
    end
  end

  def all_submitted_preferences?
    @all_participants_ids.each do |participant_id|
      unless Participant.find_by(id: participant_id).last_responded
        return false
      end
    end
    true
  end

  def modify
    @matching = Matching.find_by(params.slice(:project_id))
    @parsed_matching = JSON.parse(@matching.output_json)
    !@parsed_matching["schedule"][params[:format].split('/')[0].to_i]["timestamp"]  = params[:format].split('/')[1]
    !@matching.output_json = @parsed_matching.to_json
    @matching.save
    redirect_to project_matching_path(params[:project_id])
  end

  # GET /project/:project_id/matching
  def show
    unless logged_in?
      require_user
      return
    end

    set_show_variables
  end

  def email
    @project = Project.find(params[:project_id])
    @project.email_matchings_to_participants(params[:email_subject], params[:email_body])

    flash[:success] = 'Emails have been sent.'
    redirect_to project_matching_path(params[:project_id])
  end
  # POST /projects/:project_id/matching
  def create
    @project = Project.find_by(id: params[:project_id])
    @matching = @project.matching || Matching.new(project_id: @project.id)
    @matching.output_json = @matching.api_call

    respond_to do |format|
      if @matching.save!
        notmatched = @matching.participants_not_matched
        allmatched = (notmatched == "")
        if allmatched
          flash[:success] = 'Matching Complete. All users successfully matched.'
        else
          flash[:success] = 'Matching Complete. ' + notmatched + ' did not receive a match.'
        end
        format.html { redirect_to project_matching_path }
        # else
        #   format.html { render :new }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance_variables
      set_matching_and_project
      if @project
        @times = @project.project_times.order(:date_time)
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