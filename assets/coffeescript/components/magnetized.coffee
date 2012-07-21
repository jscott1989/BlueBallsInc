# This will send magnetism in a direction, pulling metalic objects towards me

window.game.components.magnetized =
	init: (entity) ->
		# Attach an animated beam
		# Turn the beam on
		bitmap = window.game.bitmaps.magnet_beam.clone()

		# bitmap.scaleX = 0.2
		bitmap.scaleY = 0.2

		bitmap.regX = 0 - (bitmap.image.height * 0.2) / 2
		bitmap.regY = (bitmap.image.width * 0.2) / 2

		entity.bitmaps.push(bitmap)
		entity.magnet_beam = bitmap

		window.game.stage.addChild(bitmap)

	clean: (entity) ->
		delete entity.magnet_beam

	update: (entity) ->
		# Find objects to pull

	play: (entity) ->

	reset: (entity) ->
		# Turn the beam off
	