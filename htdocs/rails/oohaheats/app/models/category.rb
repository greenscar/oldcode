class Category < ActiveRecord::Base
   has_many :categorizations
   has_many :recipes, :through => :categorizations, :class_name => "Recipe", :source => :recipe, :conditions => ['recipes.active = ?', true]
end
