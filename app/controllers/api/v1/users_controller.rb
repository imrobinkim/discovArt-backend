class Api::V1::UsersController < ApplicationController
  def profile #GET /api/v1/profile
    render json: {
      user: current_user,
      error: false
    }, status: :accepted
  end 

  def create #POST /api/v1/users
    @user = User.create(user_params)

    if @user.valid?
      render json: {
        user: @user,
        token: encode(user_id: @user.id),
        error: false
      }, status: :created
    else 
      render json: {
        message: "Sorry, we couldn't create a new user.",
        errors: @user.errors.full_messages,
        error: true
      }, status: :not_acceptable
    end
  end 

  # TODO: DELETE (created just to check out user serializer)
  def index
    render json: User.all
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end 

end
