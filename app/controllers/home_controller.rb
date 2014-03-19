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

	def relationship
		begin
			if params[:type] == "unfollow"
				response = Instagram.unfollow_user(params[:id], access_token: session[:access_token])
			elsif params[:type] == "follow"
				response = Instagram.follow_user(params[:id], access_token: session[:access_token])
			end
			render json: {error_message: "Success"}, status: 200
		rescue Instagram::BadRequest
			render json: {error_message: "Error 400: You played too much with the API ;)"}, status: 400
		rescue Instagram::NotFound
			render json: {error_message: "Error 404: Not found"}, status: 404
		rescue Instagram::InternalServerError
			render json: {error_message: "Error 500: Internal server error"}, status: 500
		rescue Instagram::ServiceUnavailable
			render json: {error_message: "Error 503: Service unavailable"}, status: 503
		rescue Exception
			render json: {error_message: "Unknown error"}, status: 999
		end
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
