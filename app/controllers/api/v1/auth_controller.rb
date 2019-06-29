class Api::V1::AuthController < ApplicationController
  #controller for when already existing user is logging back in
  
  def create #POST /api/v1/login
    @user = User.find_by(email: user_login_params[:email])

    #if user exists & password after hashing and salting matches password_digest in db...
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: {
        user: @user,
        token: token,
        message: "Successfully logged in"
        error: false
      }, status: :accepted
    else 
      render json: {
        message: "Invalid email or password",
        error: true
      }, status: :unauthorized
  end 

  private

  def user_login_params
    # params { user: {email: '...', password: '...' } }
    params.require(:user).permit(:email, :password)
  end
end
