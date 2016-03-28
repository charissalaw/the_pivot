class ProjectsController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @project = Project.find_by_slug(params[:project])
  end
end
