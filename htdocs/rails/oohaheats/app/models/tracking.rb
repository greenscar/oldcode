class Tracking < ActiveRecord::Base
   belongs_to :recipe  
   validates_presence_of :ip
   validates_presence_of :recipe_id
end
