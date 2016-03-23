class ProjectsController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @project = Project.find(params[:id])
  end

end
