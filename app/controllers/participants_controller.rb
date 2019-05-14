# frozen_string_literal: true

class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[show autofill update destroy]
  before_action :set_new_user, only: [:display]
  before_action :set_project, only: [:index, :display, :email, :handle_simple, :show]
  before_action :require_user, :ensure_owner_logged_in, only: [:display, :index, :show]

  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all
    redirect_to display_project_participants_path(params[:project_id])
  end

  # GET /participants
  def display
    @participants = Participant.where(project_id: params[:project_id])
  end

  def ensure_owner_logged_in
    unless !logged_in? or Project.where(user_id: current_user.id).ids.include? params[:project_id].to_i
      flash[:danger] = 'Access denied.'
      redirect_to projects_path
      return
    end

    unless params.keys.include? 'id'
      return
    end

    unless @project.participants.ids.include? params[:id].to_i
      flash[:danger] = 'Access denied.'
      redirect_to display_project_participants_path(@project.id)
    end
  end

  def email
    @participants = @project.participants
    email_subject = params[:email_subject]
    email_body = params[:email_body]
    ParticipantsMailer.set_project_name(@project.project_name)

    @participants.each do |participant|
      rank_link = edit_project_participant_ranking_url(
          secret_id: participant.secret_id, participant_id: participant.id, project_id: @project.id)
      ParticipantsMailer.availability_email(
          participant.email, email_subject, email_body, rank_link).deliver_now
    end

    flash[:success] = 'Emails have been sent.'
    redirect_to display_project_participants_path(params[:project_id])
  end


  # Temporary button for generating random preferences
  def autofill
    all_project_time_ids = ProjectTime.where(project_id: @participant.project_id).pluck(:id)

    all_project_time_ids.each do |project_time_id|
      ranking = Ranking.find_by(participant_id: @participant.id, project_time_id: project_time_id)
      if ranking
        ranking.update(rank: 3)
      else
        Ranking.create(participant_id: @participant.id, project_time_id: project_time_id, rank: rand(1..3))
      end
    end
    participant = Participant.find_by(id: @participant.id)
    participant.update(last_responded: Time.now.getutc)
    redirect_to display_project_participants_path(@participant.project_id)
  end

  def need_more_times?
    new_match_degree_sum = Participant.where(project_id: @participant.project_id)
                  .pluck(:match_degree).inject(:+)
    project_times_sum = ProjectTime.where(project_id: @participant.project_id, is_date: false)
                  .size
    if new_match_degree_sum > project_times_sum
      return true
    end
    false
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    # unless logged_in?
    #   require_user
    #   return
    # end

    # unless Participant.where(project_id: @project.id).ids.include? params[:id].to_i
    #   flash[:danger] = 'Access denied.'
    #   redirect_to display_project_participants_path(params[:project_id])
    # end
    # @participants = Participant.where(project_id: params[:project_id])
    # redirect_to projects_path
  end

  # GET /participants/new
  # def new
  #   @participant = Participant.new
  # end
  def handle_import
    params_participant = params[:participant]
    if params_participant
      @csv = params_participant[:file]
    end
    if @csv.nil?
      flash[:danger] = "No file uploaded."
    elsif !(@csv.content_type == "application/vnd.ms-excel" or @csv.content_type == "text/csv")
      flash[:danger] = "File is not a csv."
    else
      success, alert = Participant.import(@csv, params[:project_id])
      alert.empty? ? () : (flash[:danger] = alert)
      success.empty? ? () : (flash[:success] = "Imported participants: <br/>" + success)
    end
  end

  def handle_simple
    @participant = Participant.new(participant_params)
    @participant.project_id = params[:project_id]
    @participant.match_degree = @participant.match_degree ? @participant.match_degree : 1
    if !@participant.valid?
      flash[:danger] = @participant.errors.full_messages.first
    else
      @participant.save!
      render_participant_modified_message "created"
    end
  end

  # POST /participants
  # POST /participants.json
  def create
    params[:import] ? handle_import : handle_simple
    redirect_to display_project_participants_path(params[:project_id])
  end

  def render_participant_modified_message(action)
    if need_more_times?
      flash[:message] = "Successfully #{action} participant #{@participant.email}, but you have more matches to make than you have times. Not everyone will receive a match. Please add more times."
    else
      flash[:success] = "Successfully #{action} participant #{@participant.email}."
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        render_participant_modified_message "updated"
        format.html { redirect_to display_project_participants_path(params[:project_id]) }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    email = @participant.email
    @participant.destroy
    flash[:success] = "Successfully deleted participant #{email}."
    redirect_to display_project_participants_path(@participant.project_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      # @project = Project.find(params[:project_id])
      @project = Project.find_by(:id => params[:project_id])
    end

    def set_participant
      #@participant = Participant.find(params[:format])
      @participant = Participant.find_by(:id => params[:id])
    end

    def set_new_user
      @participant = Participant.new
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:email, :match_degree, :last_responded)
    end
end
