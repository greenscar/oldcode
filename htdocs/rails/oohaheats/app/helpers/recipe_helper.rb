module RecipeHelper  
   def recipe_has_category?(category)
      @recipe.categories.include?(category)
   end
end
