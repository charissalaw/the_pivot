class Category::CategoriesController < ApplicationController
  def show
    @category = Category.find_by(name: params[:category])
  end
end
