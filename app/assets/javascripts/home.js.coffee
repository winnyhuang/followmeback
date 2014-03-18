# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	# improve this and wait for the backend to get Instagram answer to modify any frontend
	$('.unfollow').click ->
		id = $(this).attr("id").split('_')[1]
		$(this).toggleClass("disabled")
		$('#following_'+id).toggleClass("disabled")

	$('.following').click ->
		id = $(this).attr("id").split('_')[1]
		$(this).toggleClass("disabled")
		$('#unfollow_'+id).toggleClass("disabled")