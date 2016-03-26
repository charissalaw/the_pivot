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
    @projects = current_user.projects
  end

  def update
  @project = Project.find(params[:id])
  status = @project.inactive?
  if @project.update(project_params)
    if status == true && status == @project.inactive?
      flash[:alert] = "Sorry mate! Reactivate the project!"
      return redirect_to borrower_user_projects_path(inactive: true)
    elsif status == true
      flash[:info] = "#{@project.name} has been activated"
      return redirect_to borrower_user_projects_path(inactive: true)
    elsif @project.inactive?
      flash[:alert] = "#{@project.name} has been deactivated"
    else
      flash[:info] = "Congrats! #{@project.name} has been updated!"
    end
    redirect_to borrower_user_projects_path(inactive: false)
  else
    flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong :(... Please try again."
    render :new
  end
end

  def project_params
    params.require(:project).permit(:name, :goal, :description, :country_id, :category_id, :image)
  end
end
