class MatchingsController < ApplicationController
  before_action :set_matching_and_project, only: [:show, :edit, :update, :destroy]

  # GET /project/:project_id/matching
  def show
    if @matching
      @is_matching = true
      @parsed_matching = JSON.parse(@matching.output_json)
    end
    @project_user_id = @project.user_id
  end

  # GET /projects/:project_id/matching/new
  def new
    @matching = Matching.new
  end

  # GET /projects/:project_id/matching/edit
  def edit
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

  # PATCH/PUT /projects/:project_id/matching
  def update
    respond_to do |format|
      if @matching.update(matching_params)
        format.html { redirect_to @matching, notice: 'Matching was successfully updated.' }
      else
        format.html { render :edit }
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
      # print(params)
      @matching = Matching.find_by(params.slice(:project_id))
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matching_params
      params.fetch(:matching, {})
    end
end
