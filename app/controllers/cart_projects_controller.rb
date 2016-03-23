class CartProjectsController < ApplicationController

  def create
    project = Project.find(params[:project_id])
    @cart.add_project(project.id, params[:quantity])
    session[:cart] = @cart.contents
    flash[:info] = "#{project.name} added to cart"
    redirect_to projects_path
  end

  def destroy
    project = find_project(params[:id])
    @cart.remove_project_from_cart(project.id.to_s)
    flash[:alert] = "You have removed #{view_context.link_to project.name, project_path(project.id)} from your cart."
    if @cart.empty?
      redirect_to root_path
    else
      redirect_to cart_path
    end
  end

  def update
    @cart.update(params)
    redirect_to cart_path
  end

  private

  def find_project(id)
    Project.find(id)
  end

end
