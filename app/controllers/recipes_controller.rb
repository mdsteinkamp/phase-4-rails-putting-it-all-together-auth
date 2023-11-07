class RecipesController < ApplicationController
  skip_before_action :authorize

  def index
    recipes = Recipe.all
    render json: recipes
  end

  def create
    user = User.find_by(id: session[:user_id])
    recipes = user.recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private
  
  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end
