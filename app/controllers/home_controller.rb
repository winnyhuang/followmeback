class HomeController < ApplicationController
	def index
		if session[:connected]
			client = Instagram.client
			@user = client.user

			follows = Instagram.user_follows(:count => -1)
			followers = Instagram.user_followed_by(:count => -1)

			@follows_not_back = []
			follows.each do |follow|
				follow_back = false
				followers.each do |follower|
					if follower.id == follow.id
						follow_back = true
						break
					end
				end
				if !follow_back
					@follows_not_back << follow
				end
			end
		end
	end

	def unfollow
		Instagram.unfollow_user(params[:id])
		render nothing: true, status: 200
		#TODO: handle Instagram errors (like error 400) and return to frontend appropriately 
	end

	def follow
		Instagram.follow_user(params[:id])
		render nothing: true, status: 200
	end

	def connecting
		redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => "relationships")
	end

	def callback
		response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
		Instagram.configure do |config|
			session[:connected] = true
			config.access_token = response.access_token
		end
		redirect_to :root
	end

	def logout
		session[:connected] = false
		redirect_to :root
	end
end
