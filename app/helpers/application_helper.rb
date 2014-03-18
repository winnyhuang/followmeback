module ApplicationHelper

	def is_connected
		return true if session[:connected]
		return false
	end
end
