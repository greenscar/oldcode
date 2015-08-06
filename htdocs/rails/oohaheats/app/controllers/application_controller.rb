# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
   # Pick a unique cookie name to distinguish our session data from others'
   #session :session_key => '_untitled6_session_id'
   before_filter :authorize
   protected
   # Override in controller classes that should require authentication
   def secure?
      false
   end
   
   protected
   def authorize
      if secure? && session[:user].nil?
         session["return_to"] = request.request_uri
         redirect_to :controller => "user", :action => "login"
         return false
      elsif secure?
         seclvl = session[:user].security_lvl.name
         logger.debug("-----------------------------------")
         #logger.debug(session[:user].security_lvl.name)
         logger.debug(seclvl)
         if seclvl == "moderator" || seclvl == "admin"
            logger.debug("user is a moderator or admin")
            return true
         else
            logger.debug("user is not a moderator or admin")
            return false
         end
         logger.debug("-----------------------------------")
      end
   end

   def hide_link
      if session[:user].nil?
         return true
      else
         logger.debug(session[:user][user_type][name])
         return false
      end
   end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
