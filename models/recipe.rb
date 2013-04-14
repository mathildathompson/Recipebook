class Recipe < ActiveRecord::Base
	has_many :recipe_ingredients
	belongs_to :category
	has_many :ingredients, :through => :recipe_ingredients

end
