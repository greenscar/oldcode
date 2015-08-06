class Ingredient < ActiveRecord::Base
   belongs_to :grocery
   belongs_to :measurement
   belongs_to :recipe
   default_scope :order => '`order_num`'
end
