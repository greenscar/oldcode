class Step < ActiveRecord::Base
   belongs_to :recipe  
   default_scope :order => '`order_num`'
end
