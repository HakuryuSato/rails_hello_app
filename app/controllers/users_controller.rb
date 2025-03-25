class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json

  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json

  def show
    @user = User.find(params[:id])
  end

  # GET /users/new

  def new
    @user = User.new
  end

  # GET /users/1/edit

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

  # DELETE /users/1 or /users/1.json

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: 'User was successfully destroyed.' }

      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_user
    @user = User.find(params.require(:id))
  end

  # Only allow a list of trusted parameters through.

  def user_params
    params.expect(user: %i[name email password password_confirmation])
  end
end
