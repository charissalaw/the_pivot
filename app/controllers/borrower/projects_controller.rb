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


  def project_params
    params.require(:project).permit(:name, :price, :description, :country_id, :category_id)
  end
end
