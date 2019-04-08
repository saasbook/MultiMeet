class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params.merge(:username => current_user.username))
    project_name = @project.project_name

    if project_name.nil? or project_name.empty?
      flash[:message] = "Invalid project name"
      redirect_to new_project_path and return
    elsif !Project.where(project_name: project_name, username: @project.username).blank?
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
      @projects = Project.where(username: @user.username)
    end
  end

  private
  def project_params
    params.require(:project).permit(:project_name)
  end
end
