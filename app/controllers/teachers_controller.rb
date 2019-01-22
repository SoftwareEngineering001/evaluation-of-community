class TeachersController < ApplicationController
  def new
  end
  
  def show
    @teacher = Teacher.find(params[:id])
    @tcourses = @teacher.courses.paginate(page: params[:page], per_page: 10)
  end
  
  def edit_profile
    @teacher = Teacher.find(params[:id])
  end
  
  def profile_history
    @teacher = Teacher.find(params[:id])
  end
  
  def save_teacher_info
    teacher = Teacher.find(params[:teacher_id])
    research = params[:research]
    homepage = params[:homepage]
    teacher.update(research: research, homepage: homepage)
    redirect_to teacher
  end
end
