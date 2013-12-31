class UsersController < ApplicationController
  before_action :signed_in_user,          only: [:index, :update, :edit, :destroy]
  before_action :correct_user,            only: [:update, :edit]
  before_action :admin_user,              only: :destroy
  before_action :allow_new_user_creation, only: [:new, :create]
  

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to the Best App in the universe!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      flash[:now] = 'Error updating profile'
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: 'Please sign-in' 
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def allow_new_user_creation
      redirect_to(root_url) if signed_in?
    end
end
