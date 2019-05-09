class RankingsController < ApplicationController
  before_action :set_fields, only: [:show, :edit, :create, :update, :end]
  before_action :create_rankings_hash, only: [:show]
  before_action :create_times_hash, only: [:edit]
  helper_method :valid_secret_id?

  # GET /rankings
  # GET /rankings.json
  # def index
  #   @rankings = Ranking.all
  # end

  # GET /rankings/1
  # GET /rankings/1.json
  def show
  end

  # GET /rankings/new
  def new
    @ranking = Ranking.new
  end

  def valid_secret_id?
    params[:secret_id] == @participant.secret_id
  end

  def create_rankings_hash
    @rankings_hash = Hash.new
    @rankings.each do |ranking|
      unless ranking.project_time.is_date
        date = ranking.project_time.date_time.strftime("%B %e, %Y")
        @rankings_hash[date] ||= []
        @rankings_hash[date].push(ranking)
      end
    end
  end

  def create_times_hash
    @times_hash = Hash.new
    @times.each do |time|
      unless time.is_date
        date = time.date_time.strftime("%B %e, %Y")
        @times_hash[date] ||= []
        @times_hash[date].push(time)
      end
    end
  end

  # GET /rankings/1/edit
  def edit
    unless valid_secret_id?
      flash[:message] = "Access denied."
    end
  end

  def end

  end

  # POST /rankings
  # POST /rankings.json
  def create
    @times.each do |time|
      unless params.keys.include? time.id.to_s or time.is_date
        flash[:error] = "Error: please fill in an option for each time."
        redirect_to edit_project_participant_ranking_path(:secret_id => @participant.secret_id) and return
      end
    end

    @times.each do |time|
      if time.is_date
        next
      end
      id = time.id
      rank_num = params[id.to_s].to_i
      existing_ranking = Ranking.find_by(:participant_id => @participant.id, :project_time_id => id)

      if existing_ranking
        existing_ranking.update(
            :rank => rank_num, :participant_id => @participant.id, :project_time_id => id)
      else
        new_ranking = Ranking.new(:rank => rank_num, :participant_id => @participant.id, :project_time_id => id)
        new_ranking.save!
      end
    end

    @participant.update(last_responded: Time.now.getutc)
    redirect_to end_project_participant_ranking_path
  end

  # PATCH/PUT /rankings/1
  # PATCH/PUT /rankings/1.json
  def update

  end

  # DELETE /rankings/1
  # DELETE /rankings/1.json
  # def destroy
  #   @ranking.destroy
  #   respond_to do |format|
  #     format.html { redirect_to rankings_url, notice: 'Ranking was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fields
      @project = Project.find(params[:project_id])
      @participant = Participant.find_by(:project_id => params[:project_id], :id => params[:participant_id])
      @times = @project.project_times
      @rankings = @participant.rankings

      @ranking = Ranking.find_by(:participant_id => params[:participant_id])
      if @ranking.nil?
        @ranking = Ranking.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ranking_params
      params.fetch(:ranking, {})
    end
end
