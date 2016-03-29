class Borrower::ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    @project = current_user.borrower.projects.new(project_params)
    if @project.save
      redirect_to borrower_user_path(current_user)
      flash[:info] = "Your project has been created"
    else
      render :new
      flash[:danger] = "What have you done wrong?"
    end
  end

  def index
    if params[:status] == "completed"
      @projects = current_user.projects.completed_index
    else
      @projects = current_user.projects.active_index
    end
  end

  def update
  @project = current_user.projects.find(params[:id])
    if @project.update(project_params)
      flash[:info] = "Congrats! #{@project.name} has been updated!"
      redirect_to borrower_user_projects_path(active: "status")
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @repayment = Repayment.find_by(project_id: @project.id)
  end

  def project_params
    params.require(:project).permit(:name, :goal, :description, :country_id, :category_id, :image, :status)
  end
end
