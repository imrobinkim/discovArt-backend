class ApplicationController < ActionController::API
  def some_key
    'h3y_gurl_h@yy'
  end 

  def encode(payload)
    JWT.encode(payload, some_key, 'HS256')
  end 

  def decode(token)
    #returns token: {"user_id"=>2}
    JWT.decode(token, secret_key, true, {algorithm: 'HS256'})[0]
  end 
end
