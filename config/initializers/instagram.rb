require "instagram"

CALLBACK_URL = "http://localhost:3000/oauth/callback"

Instagram.configure do |config|
	config.client_id = "5074cf1fbb9f4311af323e08968b90dd"
	config.client_secret = "1ea9bd3ec71843a7a54e7de88d6a58de"
end