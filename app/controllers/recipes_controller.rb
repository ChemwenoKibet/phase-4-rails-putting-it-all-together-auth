class RecipesController < ApplicationController

    before_action :authorize
    def index
              if session[:user_id]
                recipes = Recipe.all.includes(:user)
                render json: recipes.as_json(include: { user: { only: [:id, :username, :image_url, :bio] } }, only: [:title, :instructions, :minutes_to_complete]), status: :ok
              else
                render json: { errors: ["You need to log in to view recipes"] }, status: :unauthorized
              end
    end

    def create
        @user = User.find_by(id: session[:user_id])
        recipe = Recipe.create(recipe_params.merge(user_id: @user.id));
        

        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: {errors: recipe.errors.full_messages} , status: :unprocessable_entity
        end
    end

    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
    def authorize
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
    end
end