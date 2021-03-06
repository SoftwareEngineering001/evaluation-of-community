class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create,:destroy]
    before_action :auth_check, only: [:destroy]
    def index
        @comments = Comment.paginate(page:params[:page],per_page:10)
    end
    def new
        @comment=Comment.new
        @curcourse=Course.find(params[:course_id])
    end
    def create
        @curcourse=Course.find(params[:course_id])
        @comment=Comment.new(content:comment_params[:content],user_id:current_user.id,course_id:@curcourse.id,difficulty:comment_params[:difficulty], homework:comment_params[:homework], grading:comment_params[:grading], gain:comment_params[:gain], ratescore:comment_params[:ratescore])
        @comment_dic = comment_params
        
        if @comment.save
            @curcourse.update_course_rate(@curcourse, @comment_dic)
            redirect_to @curcourse
        else
            render 'new'
        end
    end
    def destroy
        comment=Comment.find(params[:id])
        course=comment.course
        comment.destroy
        flash[:success] = "评论已删除"
        page=params[:page].to_i
        if page==1
            redirect_to user_path(current_user,:opt=>0)
        elsif page==2
            redirect_to course   
        else
            redirect_to comments_path
        end
    end
    def edit
        @comment = Comment.find(params[:id])
        @curcourse=Course.find(params[:course_id])
    end
    def update
        @comment = Comment.find(params[:id])
        @curcourse=Course.find(params[:course_id])
        if @comment.update(comment_params)
            redirect_to @curcourse
        else
            render 'edit'
        end
    end
    private
    def comment_params
        params.require(:comment).permit(:content, :difficulty, :homework, :gain, :grading, :ratescore)
    end
    def auth_check
        redirect_to(root_url) unless current_user && (current_user.admin || Comment.find(params[:id]).user_id==current_user.id)
    end
    
end
