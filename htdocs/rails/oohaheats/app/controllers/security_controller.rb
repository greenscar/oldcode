class SecurityController < ApplicationController
   layout 'standard'
   #before_filter :login_required, :except => [:login]
   
   def login
      case request.method
         when :post
            if session[:user] = Security_User.authenticate(params[:name], params[:password])
               flash[:notice]  = 'Login successful'
               redirect_to :controller => "recipe", :action => "index"
            else
               session[:user] = nil
               flash.now[:notice]  = 'Invalid Name or Password'
               @login = params[:name]
               #redirect_to :action => "login"
            end   
      end
   end
   
   def logout
      session[:user] = nil
      flash[:notice]  = 'Logout successful'
      redirect_to :controller => "recipe", :action => "index"
   end
   
   def welcome
   end
   
end
