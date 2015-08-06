require_dependency 'password'

class UserController < ApplicationController
   layout 'standard'
   
   def login
      case request.method
         when :post
            if session[:user] = Security_User.authenticate(params[:user][:name], params[:user][:password])
               logger.debug("login successful")
               flash[:message]  = 'Login successful for ' + session[:user].name
               redirect_to :controller => "recipe", :action => "list"
            else
               logger.debug("Invalid Name or Password")
               session[:user] = nil
               flash.now[:message]  = 'Invalid Name or Password'
               @name = params[:name]
               #redirect_to :action => "login"
            end   
      end
   end
   
   def welcome
   end
   
   def logout
      reset_session
      flash[:message] = 'Logged out.'
      redirect_to :action => 'login'
   end
   
   def my_account
   end
   
end
