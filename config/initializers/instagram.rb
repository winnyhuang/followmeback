require "instagram"

#CALLBACK_URL = "http://localhost:3000/oauth/callback"
CALLBACK_URL = "http://followmeback.herokuapp.com/oauth/callback"

Instagram.configure do |config|
	config.client_id = "5074cf1fbb9f4311af323e08968b90dd"
	config.client_secret = ENV['SECRET_INSTAGRAM']
end