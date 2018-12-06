class UsersController < ApplicationController
  #before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:show, :update]
  before_action :auth_check, only: [:index, :destroy]
  def new
    @user=User.new
  end
  def index
    @users=User.paginate(page:params[:page],per_page:10)
  end
  def show
    @user=User.find(params[:id])
    opt=params[:opt].nil? ? 0 : params[:opt];
    pages=["notify","comments","interest"]
    @pageOpt=pages[opt.to_i%3]
    @ucomments = @user.comments.paginate(page: params[:page],per_page: 10)
    @curpage=1;
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "欢迎来到评课社区!"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
  def destroy
    user=User.find(params[:id])
    user.destroy
    flash[:success] = "用户已删除"
    redirect_to users_path
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  def auth_check
    redirect_to(root_url) unless current_user && current_user.admin?
  end
end
