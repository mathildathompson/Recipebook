Recipebook::Admin.controllers :recipe_ingredients do
  get :index do
    @title = "Recipe_ingredients"
    @recipe_ingredients = RecipeIngredient.all
    render 'recipe_ingredients/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'recipe_ingredient')
    @recipe_ingredient = RecipeIngredient.new
    render 'recipe_ingredients/new'
  end

  post :create do
    @recipe_ingredient = RecipeIngredient.new(params[:recipe_ingredient])
    if @recipe_ingredient.save
      @title = pat(:create_title, :model => "recipe_ingredient #{@recipe_ingredient.id}")
      flash[:success] = pat(:create_success, :model => 'RecipeIngredient')
      params[:save_and_continue] ? redirect(url(:recipe_ingredients, :index)) : redirect(url(:recipe_ingredients, :edit, :id => @recipe_ingredient.id))
    else
      @title = pat(:create_title, :model => 'recipe_ingredient')
      flash.now[:error] = pat(:create_error, :model => 'recipe_ingredient')
      render 'recipe_ingredients/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "recipe_ingredient #{params[:id]}")
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    if @recipe_ingredient
      render 'recipe_ingredients/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'recipe_ingredient', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "recipe_ingredient #{params[:id]}")
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    if @recipe_ingredient
      if @recipe_ingredient.update_attributes(params[:recipe_ingredient])
        flash[:success] = pat(:update_success, :model => 'Recipe_ingredient', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:recipe_ingredients, :index)) :
          redirect(url(:recipe_ingredients, :edit, :id => @recipe_ingredient.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'recipe_ingredient')
        render 'recipe_ingredients/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'recipe_ingredient', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Recipe_ingredients"
    recipe_ingredient = RecipeIngredient.find(params[:id])
    if recipe_ingredient
      if recipe_ingredient.destroy
        flash[:success] = pat(:delete_success, :model => 'Recipe_ingredient', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'recipe_ingredient')
      end
      redirect url(:recipe_ingredients, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'recipe_ingredient', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Recipe_ingredients"
    unless params[:recipe_ingredient_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'recipe_ingredient')
      redirect(url(:recipe_ingredients, :index))
    end
    ids = params[:recipe_ingredient_ids].split(',').map(&:strip).map(&:to_i)
    recipe_ingredients = RecipeIngredient.find(ids)
    
    if RecipeIngredient.destroy recipe_ingredients
    
      flash[:success] = pat(:destroy_many_success, :model => 'Recipe_ingredients', :ids => "#{ids.to_sentence}")
    end
    redirect url(:recipe_ingredients, :index)
  end
end
