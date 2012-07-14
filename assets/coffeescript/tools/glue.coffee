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
			entity = window.game.get_entity_at_mouse()
			if entity
				if not ('glue' of entity)
					entity.glue = []

				bitmap = window.game.bitmaps.glue.clone()

				offset = window.game.get_offset_to_mouse(entity)

				# bitmap.regX = x_offset
				# bitmap.regY = y_offset

				# bitmap.regX = bitmap.image.width / 2
				# bitmap.regY = bitmap.image.width / 2

				# bitmap.x = (position.x + x_offset) * window.game.scale
				# bitmap.y = (position.y + y_offset) * window.game.scale

				bitmap.regX = window.game.meters_to_pixels(offset.x) + (bitmap.image.width / 2)
				bitmap.regY = window.game.meters_to_pixels(offset.y) + (bitmap.image.width / 2)

				entity.bitmaps.push(bitmap)
				window.game.stage.addChild(bitmap)

				# TO DO THIS - we probably have to double the rotation on the entity, then position the glue
				entity.glue.push({"position": "TODO"})