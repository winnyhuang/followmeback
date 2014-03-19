module ApplicationHelper

	def is_connected
		return true if session[:access_token]
		return false
	end
end
