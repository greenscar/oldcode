class Security_User < ActiveRecord::Base
   validates_uniqueness_of :name 
   belongs_to :security_lvl
   validates_confirmation_of :password, :on => :create
   validates_length_of :password, :within => 5..40
   
   # If a user matching the credentials is found, returns the User object.
   # If no matching user is found, returns nil.
   def authenticate1
      logger.debug("user.authenticate");
      logger.debug("name = " + name)
      logger.debug("password = " + password)
      user = User.find_by_name_and_password(self.name, self.password)
      if(user != nil)
         logger.debug(user)
      elsif(Password::check(password, user.password))
         user
      else
         return false
      end
      logger.debug("END user.authenticate");
   end
   
   def self.authenticate(name, pass)
      # Find the user in the db
      user = find(:first, :joins => :security_lvl, :conditions => ['security_users.name = ?',name])
      #user.build_security_lvl
      #user.load
      #logger.debug("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
      #if user.security_lvl.nil?
      #   logger.debug("error loading security level")
      #   logger.debug(user.security_lvl)
      #end
      #logger.debug("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
      #begin
      #   logger.debug("name = " + user.name)
      #   logger.debug("security_lvl = " + user.security_lvl.name)
      #rescue
      #   logger.debug("User & Security Level not correctly loaded")
      #end
      #logger.debug("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
      if(user != nil)
         #logger.debug("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
         #logger.debug("pass = " + pass)
         #logger.debug("user.password = " + user.password)
         #logger.debug("check password = " + Password::check(pass,user.password).to_s)
         #logger.debug("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
         if Password::check(pass,user.password)
            user
         else
            return false
         end
      else
         return false
      end
   end
   
   def before_create
      logger.debug("old password = " + self.password)
      self.password = Password::update(self.password)
      logger.debug("new password = " + self.password)
   end
   # Checks login information
   #def self.authenticate(nick, pass)
   #   user = find(:first, :conditions => ['nick = ?',nick])
   #   if Password::check(pass,user.password)
   #      user
   #   else
   #      return false
   #   end
   #end
   #
   #protected
   #def password=(pass)
   #   write_attribute(:password, password = Password::update(pass))
   #end
   def is_admin
      if self.security_lvl.name == "admin"
         logger.debug("TRUE")
         return true
      else
         logger.debug("FALSE")
         return false
      end
   end
end
