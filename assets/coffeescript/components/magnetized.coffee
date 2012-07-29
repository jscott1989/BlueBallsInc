# This will send magnetism in a direction, pulling metalic objects towards me

MAX_FORCE = 15000

MAX_DISTANCE = window.game.pixels_to_meters(500)

window.game.components.magnetized =
	init: (entity) ->
		# Attach an animated beam
		# Turn the beam on
		# bitmap = window.game.bitmaps.magnet_beam.clone()

		# # bitmap.scaleX = 0.2
		# bitmap.scaleY = 0.2

		# bitmap.regX = 0 - (bitmap.image.height * 0.2) / 2
		# bitmap.regY = (bitmap.image.width * 0.2) / 2

		# entity.bitmaps.push(bitmap)
		# entity.magnet_beam = bitmap

		# window.game.stage.addChild(bitmap)

	update: (entity) ->
		# Find objects to pull

		if window.viewModel.state() == 'PLAY'
			if entity.fixtures.length > 0
				position = entity.fixtures[0].GetBody().GetPosition();

				for e in window.game.entities
					if 'magnetic' in e.tags
						body = e.fixtures[0].GetBody()
						e_position = body.GetPosition()

						bigger_distance = Math.abs(position.x - e_position.x)
						if Math.abs(position.y - e_position.y) > bigger_distance
							bigger_distance = Math.abs(position.y - e_position.y)

						if bigger_distance > MAX_DISTANCE
							continue

						# xspeed = (MAX_DISTANCE - Math.abs(position.x - e_position.x)) * FORCE_PER_METER
						# yspeed = (MAX_DISTANCE - Math.abs(position.y - e_position.y)) * FORCE_PER_METER
						xspeed = 2500
						yspeed = 4000

						console.log xspeed, yspeed
						if e_position.x > position.x
							xspeed = 0 - xspeed
						if e_position.y > position.y
							yspeed = 0 - yspeed

						body.ApplyForce(new B2Vec2(xspeed, yspeed), body.GetWorldCenter())

	play: (entity) ->

	reset: (entity) ->
		# Turn the beam off
	