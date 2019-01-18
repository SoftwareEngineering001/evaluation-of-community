class BasicsController < ApplicationController
  def search
    @keywords = params[:q]
    @searchcourses=Course.joins(:teachers).distinct.where("title LIKE ?","%#{@keywords}%").or("name=?",@keywords)
                  .paginate(page:params[:page],per_page:15)
  end
  
end
