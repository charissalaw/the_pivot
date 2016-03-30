class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_slug(params[:slug])
  end

  def search
    redirect_to category_path(params[:category_search])
  end
end
