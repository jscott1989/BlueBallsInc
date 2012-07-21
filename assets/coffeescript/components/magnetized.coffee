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

		position = entity.fixture.GetBody().GetPosition();
		# endOfRay = new B2Vec2(startOfRay.x + 20, startOfRay.y);

		# endOfRay = window.game.rotate_point(endOfRay, startOfRay, entity.fixture.GetBody().GetAngle())

		hit_entities = {}

		# callback = (fixture, normal, fraction) ->
		# 	e = window.game.get_entity_by_fixture(fixture)

		# 	if 'magnetic' in e.tags
		# 		if not (e.id of hit_entities)
		# 			hit_entities[e.id] = e
		# 	return 1

		callback = (fixture) ->
			e = window.game.get_entity_by_fixture(fixture)

			if 'magnetic' in e.tags
				if not (e.id of hit_entities)
					hit_entities[e.id] = e
			return 1

		# window.physics.world.RayCast(callback, startOfRay, endOfRay);
		aabb = new B2AABB()

		aabb.lowerBound = new B2Vec2(position.x - window.game.pixels_to_meters(entity.bitmaps[0].width / 2), position.y - window.game.pixels_to_meters(entity.bitmaps[0].height / 2))
		aabb.upperBound = new B2Vec2(position.x + 20, position.y + window.game.pixels_to_meters(entity.bitmaps[0].height / 2))

		aabb.lowerBound = window.game.rotate_point(aabb.lowerBound, position, entity.fixture.GetBody().GetAngle())
		aabb.upperBound = window.game.rotate_point(aabb.upperBound, position, entity.fixture.GetBody().GetAngle())

		window.physics.world.QueryAABB(callback, aabb);

		for e of hit_entities
			body = hit_entities[e].fixture.GetBody()
			e_position = body.GetPosition()

			xspeed = position.x - e_position.x
			yspeed = position.y - e_position.y

			body.ApplyForce(new B2Vec2(xspeed * 1000, yspeed * 1000), body.GetWorldCenter())

	play: (entity) ->

	reset: (entity) ->
		# Turn the beam off
	