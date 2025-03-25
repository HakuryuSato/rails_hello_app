# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save

      reset_session

      log_in @user

      flash[:success] = 'Welcome to the Sample App!'

      redirect_to @user

    else

      render 'new', status: :unprocessable_entity

    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: 'User was successfully destroyed.' }

      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params.require(:id))
  end

  def user_params
    params.expect(user: %i[name email password password_confirmation])
  end
end
