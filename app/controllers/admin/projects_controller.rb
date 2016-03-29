class Admin::ProjectsController < Admin::BaseController

  def index
    if params[:status] == "completed"
      @projects = Project.completed_index
    elsif params[:status] == "deactive"
      @projects = Project.inactive_index
    else
      @projects = Project.active_index
    end
  end

  def update
    project = Project.find(params[:id])
    if params[:commit] == "deactivate project"
      project.update(status: "active")
      redirect_to admin_projects_path(current_user, status: "active")
      flash[:info] = "Project #{project.id} has been deactivated."
    else
      render :index
    end
  end
end
