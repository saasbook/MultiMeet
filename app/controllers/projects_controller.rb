class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.update(project_name: :project_name)
    @project.update(username: :username)

    # print(@project)

    if @project.save
      flash[:success] = "Successfully created #{@project.project_name}!"
      redirect_to projects_path
    else
      flash[:message] = @user.errors.full_messages
      redirect_to projects_path
    end
  end

  def index
    @user = current_user
    print(@user)
    if @user
      print(@user)
      @projects = Project.where(username: @user.username)
    end
  end

  private
  def project_params
    params.require(:project).permit(:project_name, :username)
  end
end
