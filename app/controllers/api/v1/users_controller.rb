class Api::V1::UsersController < ApplicationController
  def profile #GET /api/v1/profile
    # byebug
    render json: {
      user: current_user,
      error: false
    }, status: :accepted
  end 

  def create #POST /api/v1/users
    # byebug
    @user = User.create(user_params)

    if @user.valid?
      render json: {
        user: @user,
        token: encode(user_id: @user.id),
        error: false
      }, status: :created
    else 
      render json: {
        message: "couldn't create user",
        error: @user.errors.full_messages
      }, status: :not_acceptable
    end
  end 

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end 

end
