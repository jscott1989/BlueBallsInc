# Allows glue to be placed on an entity, and will join together 
# two entities when they touch for long enough on a glued area

window.game.components.gluable =
	init: (entity) ->
		entity.glue = []

		entity.add_glue = (offset) ->
			bitmap = window.game.bitmaps.glue.clone()

			bitmap.regX = window.game.meters_to_pixels(offset.x) + (bitmap.image.width / 2)
			bitmap.regY = window.game.meters_to_pixels(offset.y) + (bitmap.image.width / 2)

			entity.bitmaps.push(bitmap)
			entity.glue.push({"x": offset.x, "y": offset.y, "bitmap": bitmap})

			window.game.stage.addChild(bitmap)

		entity.clean_glue = (offset) ->
			min_x = offset.x - 0.2
			max_x = offset.x + 0.2
			min_y = offset.y - 0.2
			max_y = offset.y + 0.2

			glue_to_remove = []

			for glue in entity.glue
				if glue.x > min_x and glue.x < max_x and glue.y > min_y and glue.y < max_y
					glue_to_remove.push(glue)

			for glue in glue_to_remove
				window.game.stage.removeChild(glue.bitmap)

				# Remove from entity.glue
				idx = entity.glue.indexOf(glue)
				if idx != -1
					entity.glue.splice(idx, 1)

				# Remove from entity.bodies
				idx = entity.bitmaps.indexOf(glue.bitmap)
				if idx != -1
					entity.bitmaps.splice(idx, 1)

	update: (entity) ->
		# for touching of entity.touching
		# 	# Here, see if the other entity is touching anywhere that has glue
		# 	other_entity = window.game.entityIDs[touching]
			
		# 	body = entity.fixture.GetBody()
		# 	other_body = other_entity.fixture.GetBody()

		# 	position = body.GetPosition()
		# 	other_position = other_body.GetPosition()

		# 	console.log body

			# for glue in entity.glue
