require "instagram"

if Rails.env == "development" || Rails.env == "test"
	CALLBACK_URL = ENV['INSTAGRAM_DEV_CALLBACK']
	Instagram.configure do |config|
		config.client_id = ENV['INSTAGRAM_DEV_CLIENT']
		config.client_secret = ENV['INSTAGRAM_DEV_SECRET']
	end
else
	CALLBACK_URL = ENV['INSTAGRAM_PROD_CALLBACK']
	Instagram.configure do |config|
		config.client_id = ENV['INSTAGRAM_PROD_CLIENT']
		config.client_secret = ENV['INSTAGRAM_PROD_SECRET']
	end
end