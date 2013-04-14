require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class RecipeIngredientTest < Test::Unit::TestCase
  context "RecipeIngredient Model" do
    should 'construct new instance' do
      @recipe_ingredient = RecipeIngredient.new
      assert_not_nil @recipe_ingredient
    end
  end
end
