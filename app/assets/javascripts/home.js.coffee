# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$('.relationship').click ->
		button = $(this)
		type = $(this).data('type')
		id = $(this).data('id')
		loader = $('#loader_'+id)

		button.toggleClass('disabled')
		loader.toggleClass('hide')

		$.ajax '/home/relationship',
			type: 'POST'
			dataType: 'json'
			data:
				type: type
				id: id
			error: (jqXHR) ->
				console.log jQuery.parseJSON(jqXHR.responseText).error_message
				alert(jQuery.parseJSON(jqXHR.responseText).error_message)
				button.toggleClass('disabled')
				loader.toggleClass('hide')
			success: (data, textStatus, jqXHR) ->
				console.log jQuery.parseJSON(jqXHR.responseText).error_message
				#alert(jQuery.parseJSON(jqXHR.responseText).error_message)
				if (type == 'follow')
					$('#unfollow_'+id).toggleClass('disabled')
				else
					$('#follow_'+id).toggleClass('disabled')
				loader.toggleClass('hide')
