class BasicsController < ApplicationController
  def search
    @keywords = params[:q]
    @courses = Course.all
    strings = Array.new
    @courses.each do |course|
      for i in 0..@keywords.size-1
          if(course.title.include?@keywords[i])
              strings.push(course.title)
          end
      end
    end
        # @searchcourses = 
    @searchcourses=Course.where(title: strings).order("comment_counts ASC").
    paginate(page:params[:page],per_page:10)
    # @searchcourses = searchcourse(@keywords)
  end
  
end
