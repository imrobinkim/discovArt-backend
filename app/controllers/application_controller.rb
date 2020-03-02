class ApplicationController < ActionController::API
  def some_key
    'h3y_gurl_h@yy'
  end 

  def encode(payload)
    # {user_id: 2}
    JWT.encode(payload, some_key, 'HS256')
  end 

  def decode(token)
    #returns payload: {"user_id"=>2}
    JWT.decode(token, some_key, true, {algorithm: 'HS256'})[0]
  end 

  def current_user
    # server has access to request obj when fetch is being made. Take out 'Bearer ' to get token
    if request.headers['Authentication']
      token = request.headers['Authentication'].split(' ')[1]
      if token
        payload = decode(token)
        @user = User.find_by(id: payload["user_id"])
      end 
    end
  end
end
