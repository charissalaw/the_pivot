class Admin::ProjectsController < ApplicationController

  def index
    @projects = Search.admin_projects(params)
    if @projects.nil?
      @borrower = Borrower.find_by(id: params[:id_search])
      if @borrower
        redirect_to admin_borrower_path(@borrower)
      else
        flash[:alert] = "Borrower #{params[:id_search]}  doesn't exist!"
        redirect_to admin_projects_path(current_user, status: "active")
      end
    end
  end

  def update
    project = Project.find(params[:id])
    if params[:commit] == "deactivate project"
      project.update(status: "deactive")
      flash[:alert] = "Project #{project.name} has been deactivated."
      redirect_to admin_borrower_path(project.borrower)
    elsif params[:commit] == "update project"
      project.update(project_params)
      flash[:info] = "Project #{project.name} has been updated."
      redirect_to admin_borrower_path(project.borrower)
    else
      flash[:alert] = "Something went wrong... The project has not been updated."
      redirect_to admin_borrower_path(project.borrower)
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to admin_borrower_path(@project.borrower)
      flash[:info] = "A project has been created for #{@project.borrower.user.fullname}"
    else
      redirect_to admin_borrower_path(params[:project][:borrower_id])
      flash[:alert] = "What have you done wrong?"
    end
  end

private
  def project_params
    params.require(:project).permit(:name, :goal, :description, :country_id, :category_id, :image, :status, :borrower_id)
  end
end
