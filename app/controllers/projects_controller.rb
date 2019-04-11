class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit]

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    project_name = @project.project_name

    if project_name.nil? or project_name.empty?
      flash[:message] = "Invalid project name"
      redirect_to new_project_path and return
    elsif !Project.where(
        project_name: project_name, user_id: @project.user_id).blank?
      flash[:message] = "Project name already exists"
      redirect_to new_project_path and return
    end

    if @project.save!
      flash[:success] = "Successfully created project #{project_name}"
      redirect_to projects_path
    else
      flash[:message] = @user.errors.full_messages
      redirect_to projects_path
    end
  end

  def index
    @user = current_user
    if @user
      @projects = @user.projects # Project.where(user_id: @user.id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      # print(params)
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:project_name)
    end
end