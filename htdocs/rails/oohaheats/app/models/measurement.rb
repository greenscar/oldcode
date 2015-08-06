class Measurement < ActiveRecord::Base
   has_many :ingredients
   has_many :recipes, :through => :ingredients
   validates_presence_of :name
end
