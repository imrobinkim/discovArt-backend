class Api::V1::AuthController < ApplicationController
  # Controller for when already existing user is logging back in

  def create #POST /api/v1/login
    @user = User.find_by(email: user_login_params[:email])

    # If user exists & password after hashing and salting matches password_digest in db...
    if @user && @user.authenticate(user_login_params[:password])
      render json: {
        user: @user,
        token: encode({ user_id: @user.id }),
        message: "Successfully logged in",
        error: false
      }, status: :accepted
    elsif @user
      # If user exists BUT password doesn't match
      render json: {
        errors: {
          password: "Invalid password. Please try again."
        },
        error: true
      }, status: :unauthorized
    else
      # If user DOESN'T exist in db
      render json: {
        errors: {
          email: "Sorry, we couldn't find an account with this email."
        },
        error: true
      }, status: :unauthorized
    end
  end 

  private

  def user_login_params
    # params { user: {email: '...', password: '...' } }
    params.require(:user).permit(:email, :password)
  end
end

# ------------- Notes on Errors ----------------- #
# Error Response object sent back follows format (after translated to json):
# {
#   errors: {
#     password: "Invalid password. Please try again."
#   }, 
#   error: true
# }
# 
# On frontend, we set local state in LoginForm with response.errors if user is unable to log in successfully.