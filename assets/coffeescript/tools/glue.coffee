window.game.tools.GLUE =
	mouse_is_down: false

	select: () ->

	deselect: () ->

	mouse_down: (e) ->
		window.game.tools.GLUE.mouse_is_down = true
	mouse_up: (e) ->
		window.game.tools.GLUE.mouse_is_down = false

	update: () ->
		if window.game.tools.GLUE.mouse_is_down
			console.log "GLUE"