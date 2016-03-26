class Admin::ProjectsController < Admin::BaseController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:info] = "Congrats! #{@project.name} created!"
      redirect_to admin_dashboard_path
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def index
    if params[:inactive] == "true"
      @projects = Project.inactive_index
    else
      @projects = Project.active_index
    end
  end

  def update
    @project = Project.find(params[:id])
    status = @project.inactive?

    if @project.update(project_params)
      if status == true && status == @project.inactive?
        flash[:alert] = "Sorry mate! Reactivate the project!"
        return redirect_to admin_projects_path(inactive: true)
      elsif status == true
        flash[:info] = "#{@project.name} has been activated"
        return redirect_to admin_projects_path(inactive: true)
      elsif @project.inactive?
        flash[:alert] = "#{@project.name} has been deactivated"
      else
        flash[:info] = "Congrats! #{@project.name} has been updated!"
      end
      redirect_to admin_projects_path(inactive: false)
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong :(... Please try again."
      render :new
    end
  end

private

  def project_params
    params.require(:project).permit(:name, :goal, :description, :image, :sale, :sale_goal, :category_id, :inactive)
  end
end
