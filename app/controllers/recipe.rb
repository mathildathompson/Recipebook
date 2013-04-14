Recipebook::App.controllers :recipe do
  
  get :index do
    @recipes = Recipe.all
    @category = Category.all
    render 'recipe/index'
  end

  get :show, :map => 'recipe/:name' do
    @recipes = Category.find_by_name(params[:name]).recipes
    render 'recipe/show'
  end

  get :ingredient, :map => 'recipe/ingredient/:name' do
    @recipes = Recipe.find_by_name(params[:name]).ingredients
    render 'recipe/ingredient'
  end

end
