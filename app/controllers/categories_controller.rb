class CategoriesController < ApplicationController

  def index
  end

  def create
    @category = Category.new(category_params)
  end

  def update
    @category.update(category_params)

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end