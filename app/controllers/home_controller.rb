class HomeController < ApplicationController
	def index
		if session[:access_token]
			client = Instagram.client(access_token: session[:access_token])
			@user = client.user

			follows = Instagram.user_follows(access_token: session[:access_token], count: -1)
			followers = Instagram.user_followed_by(access_token: session[:access_token], count: -1)

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
		Instagram.unfollow_user(params[:id], access_token: session[:access_token])
		render nothing: true, status: 200
		#TODO: handle Instagram errors (like error 400) and return to frontend appropriately 
	end

	def follow
		Instagram.follow_user(params[:id], access_token: session[:access_token])
		render nothing: true, status: 200
	end

	def connecting
		redirect_to Instagram.authorize_url(redirect_uri: CALLBACK_URL, scope: "relationships")
	end

	def callback
		response = Instagram.get_access_token(params[:code], redirect_uri: CALLBACK_URL)
		session[:access_token] = response.access_token
		redirect_to :root
	end

	def logout
		session[:access_token] = nil
		redirect_to :root
	end
end
