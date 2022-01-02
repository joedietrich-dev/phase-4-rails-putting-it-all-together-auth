class RecipesController < ApplicationController
  def create
    recipe = @current_user.recipes.create!(recipe_params)
    render json: recipe, include: [:user], status: :created
  end

  def index
    recipes = Recipe.all
    render json: recipes, include: [:user]
  end

  private
  def recipe_params
    params.permit(:minutes_to_complete, :title, :instructions)
  end
end
