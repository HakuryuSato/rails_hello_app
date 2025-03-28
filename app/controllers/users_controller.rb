# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :correct_user, only: [ :edit, :update ]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin? && !current_user?(@user)
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url, status: :see_other
    else
      flash[:danger] = "You are not authorized to perform this action."
      redirect_to root_url, status: :see_other
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    unless current_user?(@user)
      flash[:danger] = "You are not authorized to perform this action."
      redirect_to(root_url, status: :see_other)
    end
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
