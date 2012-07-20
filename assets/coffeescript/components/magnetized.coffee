# This will send magnetism in a direction, pulling metalic objects towards me

window.game.components.magnetized =
	init: (entity) ->
		# Attach an animated beam

	update: (entity) ->
		# Find objects to pull

	play: (entity) ->
		# Turn the beam on
		bitmap = window.game.bitmaps.magnet_beam.clone()

		# bitmap.regX = window.game.meters_to_pixels(offset.x) + (bitmap.image.width / 2)
		# bitmap.regY = window.game.meters_to_pixels(offset.y) + (bitmap.image.width / 2)

		entity.bitmaps.push(bitmap)
		entity.magnet_beam = bitmap

		window.game.stage.addChild(bitmap)

	reset: (entity) ->
		# Turn the beam off
	