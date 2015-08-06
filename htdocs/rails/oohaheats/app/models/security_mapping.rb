class SecurityMapping < ActiveRecord::Base
   belongs_to :security_user
   belongs_to :security_lvl
end
