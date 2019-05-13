# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit]
  helper_method :responded, :num_responded

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    unless logged_in?
      require_user
      return
    end

    unless Project.where(user_id: current_user.id).ids.include? params[:id].to_i
      flash[:danger] = 'Access denied.'
      redirect_to projects_path
    end
  end

  # GET /times/1/edit
  # def edit
  #
  # end

  def update
    @project = Project.find(params[:id].to_i)
    new_project_name = project_params[:project_name]

    if valid_renaming? new_project_name
      @project.update(project_name: new_project_name)
      flash[:success] = "Successfully renamed project to #{new_project_name}"
      redirect_to project_path(@project)
    else
      redirect_to edit_project_path(@project)
    end
  end

  # returns true if ok, false if not
  def valid_project_name?(project_name)
    if project_name.nil? || project_name.empty?
      flash[:danger] = 'Invalid project name'
      return false
    elsif !Project.where(
      project_name: project_name, user_id: @project.user_id
    ).blank?
      flash[:danger] = 'Project name already exists'
      return false
    end
    true
  end

  def valid_renaming?(project_name)
    if @project.project_name == project_name
      flash[:danger] = 'Cannot rename to same project name'
      return false
    end
    valid_project_name? project_name
  end

  def redirect_based_on_create_type(project_name)
    if params[:commit] == 'Create Project and Choose Times'
      flash[:success] = "Successfully created project #{project_name}. Choose dates and times now!"
      redirect_to new_project_time_path(@project)
    else
      flash[:success] = "Successfully created project #{project_name}"
      redirect_to projects_path
    end
  end

  def create
    @project = current_user.projects.new(project_params)
    project_name = @project.project_name

    unless valid_project_name? project_name
      redirect_to(new_project_path) && return
    end

    if @project.save!
      redirect_based_on_create_type(project_name)
      # else
      #   flash[:message] = @user.errors.full_messages
      #   redirect_to projects_path
    end
  end

  # GET /times
  # GET /times.json
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

  def num_responded(id)
    count = 0
    Participant.where(project_id: id).pluck(:last_responded).each do |answer|
      unless answer.nil?
        count += 1
      end
    end
    count
  end

  def responded(id)
    count = num_responded(id)
    count.to_f / Participant.where(project_id: id).pluck(:last_responded).length.to_f
  end

end
