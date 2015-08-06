class Recipe < ActiveRecord::Base
   validates_presence_of :name
   has_many :categorizations
   has_many :categories, :through => :categorizations
   has_many :steps
   has_many :ingredients
   has_many :measurements, :through => :ingredients
   has_many :groceries, :through => :ingredients
   has_many :trackings
   has_many :ratings
   
end
