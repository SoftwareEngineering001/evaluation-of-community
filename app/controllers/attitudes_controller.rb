class AttitudesController < ApplicationController
    before_action :logged_in_user 
    def follow
        @course = Course.find(params[:course_id])
        current_user.follow_course(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    
    def unfollow
        @course = Course.find(params[:course_id])
        current_user.unfollow_course(@course)
        respond_to do |format|
          format.html { redirect_to @course }
          format.js
        end
    end
    
    def recom
        @course = Course.find(params[:course_id])
        current_user.recom_course(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    
    def unrecom
        @course = Course.find(params[:course_id])
        current_user.unrecom_course(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    
    def disrecom
        @course = Course.find(params[:course_id])
        current_user.disrecom_course(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    
    def undisrecom
        @course = Course.find(params[:course_id])
        current_user.undisrecom_course(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    
    def learn
        @course = Course.find(params[:course_id])
        current_user.learn_course(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    
    def unlearn
        @course = Course.find(params[:course_id])
        current_user.unlearn_course(@course)
        respond_to do |format|
            format.html { redirect_to @course }
            format.js
        end
    end
    
    def approve
        @course = Course.find(params[:course_id])
        @comment = Comment.find(params[:comment_id])
        current_user.approve_comment(@comment)
        respond_to do |format|
            # format.html { redirect_to @course }
            format.js
        end
    end
    
    def unapprove
        @course = Course.find(params[:course_id])
        @comment = Comment.find(params[:comment_id])
        current_user.unapprove_comment(@comment)
        respond_to do |format|
            # format.html { redirect_to @course }
            format.js
        end
    end

end
