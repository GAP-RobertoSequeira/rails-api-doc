class Api::UsersController < ApplicationController

  before_action :find_user, only: [:show, :update, :destroy]


  def index
    @users = User.all

    render json: @users
  end

  def create
    User.create(user_params)
  end

  def show
    if stale?(last_modified: @user.updated_at, public: true)
      render json: @user
    end
  end

  def update
    @user.update!(user_params)
  end

  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name)
  end

end
