class Ingredient < ActiveRecord::Base
   has_many :recipes, :through => :recipe_ingredients
   has_many :recipe_ingredients
end
