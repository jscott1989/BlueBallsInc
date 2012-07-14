window.game.tools.CLEAN =
	update: () ->
		if window.game.mouse_down
			entity = window.game.get_entity_at_mouse()
			if entity
				offset = window.game.get_offset_to_mouse(entity)
				entity.clean_glue(offset)