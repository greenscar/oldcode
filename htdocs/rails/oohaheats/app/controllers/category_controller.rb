class CategoryController < ApplicationController
   layout 'standard'
   #protected
   def secure?
      ["create"].include?(action_name)
   end
   def list
      @categories = Category.find(:all)
   end
   def show
      @category = Category.find(params[:id])
   end
   def create
      @category = Category.new(params[:category])
      if @category.save
         render :partial => 'category', :object => @category
      end
   end
end
