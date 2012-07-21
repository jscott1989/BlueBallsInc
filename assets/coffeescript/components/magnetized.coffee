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

		startOfRay = entity.fixture.GetBody().GetPosition();
		endOfRay = new B2Vec2(startOfRay.x + 20, startOfRay.y);

		endOfRay = window.game.rotate_point(endOfRay, startOfRay, entity.fixture.GetBody().GetAngle())

		# console.log startOfRay, endOfRay

		callback = (fixture, normal, fraction) ->
			e = window.game.get_entity_by_fixture(fixture)

			if 'magnetic' in e.tags
				console.log e.name
			return 1

		window.physics.world.RayCast(callback, startOfRay, endOfRay);

	play: (entity) ->

	reset: (entity) ->
		# Turn the beam off
	