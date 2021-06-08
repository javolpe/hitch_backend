class Api::V1::UsersController < ApplicationController
  before_action :validate_id, only: [:show]

  def create
    @user = User.create!(user_params)
    if @user.save 
      created_user = UserSerializer.new(@user)
      render json: created_user
    else
      invalid_params
    end
  end

  def show
    user = User.find(params[:id])
    profile = Profile.new(user)
    render json: ProfileSerializer.new(profile)
  end

  private

  def user_params
    params.permit(:email, :password, :bio, :fullname)
  end
end
