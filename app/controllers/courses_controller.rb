class CoursesController < ApplicationController
    before_action :auth_check, only: [:destroy]
    
    def index
        @courses = Course.paginate(page:params[:page],per_page:15)
    end
    def show
        @course=Course.find(params[:id])
        @ccomments = @course.comments.paginate(page:params[:page],per_page:10)
        @curpage=2;
        @comment_detail_view=true;
    end
    def upload
        uploaded_io = params[:course_csv]
        begin
            Course.readCSV(uploaded_io)
        rescue
            flash[:danger] = 'csv文件格式不正确，或者课程有重复'
        end
        redirect_to courses_path
    end
    def destroy
        course=Course.find(params[:id])
        course.destroy
        flash[:success] = "课程已删除"
        redirect_to courses_path
    end
    
    def editcourse
        @course = Course.find(params[:id])
    end
    
    def save_course_info
        course = Course.find(params[:course_id])
        introduction = params[:introduction]
        homepage = params[:homepage]
        if(introduction != ''&& homepage != '')
            course.update(introduction: introduction, homepage: homepage)
            redirect_to course
        end
    end
        
    private
    def auth_check
        redirect_to(courses_path) unless current_user && current_user.admin?
    end
    
    # def follow
    # end
    
    # def unfollow
    # end
    
    
end
