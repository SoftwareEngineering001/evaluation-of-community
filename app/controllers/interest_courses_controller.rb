class InterestCoursesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @course = Course.find(params[:course_id])
        current_user.interest(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    def destroy
        @course = InterestCourse.find(params[:id]).course
        current_user.uninterest(@course)
        respond_to do |format|
          format.html { redirect_to @course }
          format.js
        end
    end
end
