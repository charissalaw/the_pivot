class ProjectsController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @project = Project.find_by_slug(params[:project])
  end

  def update
    @project = current_user.projects.find_by_slug(params[:project])
    if @project.update(project_params)
      flash[:info] = "Congrats! #{@project.name} has been updated!"
      redirect_to borrower_user_projects_path(active: "active")
    else
      render :new
    end
  end

private
  def project_params
    params.require(:project).permit(:name, :goal, :description, :country_id, :category_id, :image, :status)
  end
end
