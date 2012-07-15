###global Box2D:false, $:false###

B2MouseJointDef =  Box2D.Dynamics.Joints.b2MouseJointDef
B2Vec2 = Box2D.Common.Math.b2Vec2;
B2AABB = Box2D.Collision.b2AABB;
B2BodyDef = Box2D.Dynamics.b2BodyDef;
B2Body = Box2D.Dynamics.b2Body;
B2FixtureDef = Box2D.Dynamics.b2FixtureDef;
B2Fixture = Box2D.Dynamics.b2Fixture;
B2World = Box2D.Dynamics.b2World;
B2MassData = Box2D.Collision.Shapes.b2MassData;
B2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape;
B2CircleShape = Box2D.Collision.Shapes.b2CircleShape;
B2DebugDraw = Box2D.Dynamics.b2DebugDraw;
B2RevoluteJointDef = Box2D.Dynamics.Joints.b2RevoluteJointDef
B2DistanceJointDef = Box2D.Dynamics.Joints.b2DistanceJointDef
B2WeldJointDef = Box2D.Dynamics.Joints.b2WeldJointDef
B2ContactListener = Box2D.Dynamics.b2ContactListener

window.physics =
	world: new B2World(new B2Vec2(0,10),  true)
	entities_to_delete: [] # Things to be deleted at the end of the current step

	begin_contact: (contact) ->
		# Begin contact between two elements
		bodyA = contact.GetFixtureA().GetBody()
		bodyB = contact.GetFixtureB().GetBody()

		entityA = window.game.entityIDs[bodyA.userData]
		entityB = window.game.entityIDs[bodyB.userData]

		manifold = contact.GetManifold()

		entityA.touching[entityB.id] = {"manifold": manifold}
		entityB.touching[entityA.id] = {"manifold": manifold}

		for component in entityA.components
			if "begin_contact" of window.game.components[component]
				window.game.components[component].begin_contact(entityA, entityB)
		for component in entityB.components
			if "begin_contact" of window.game.components[component]
				window.game.components[component].begin_contact(entityB, entityA)

	end_contact: (contact) ->
		# End contact between two elements
		bodyA = contact.GetFixtureA().GetBody()
		bodyB = contact.GetFixtureB().GetBody()

		entityA = window.game.entityIDs[bodyA.userData]
		entityB = window.game.entityIDs[bodyB.userData]

		for component in entityA.components
			if "end_contact" of window.game.components[component]
				window.game.components[component].end_contact(entityA, entityB)
		for component in entityB.components
			if "end_contact" of window.game.components[component]
				window.game.components[component].end_contact(entityB, entityA)

		delete entityA.touching[entityB.id]
		delete entityB.touching[entityA.id]


	init: () ->
		# Initialise the physics engine

		window.physics.contact_listener = new B2ContactListener()

		window.physics.contact_listener.BeginContact = window.physics.begin_contact
		window.physics.contact_listener.EndContact = window.physics.end_contact

		window.physics.world.SetContactListener(window.physics.contact_listener);

		# Set up DebugDraw
		debugDraw = new B2DebugDraw()
		debugDraw.SetSprite(window.game.debug_canvas.getContext("2d"))
		debugDraw.SetDrawScale(30)							# Scale
		debugDraw.SetFillAlpha(0.3)							# Transparency
		debugDraw.SetLineThickness(1.0)
		debugDraw.SetFlags(B2DebugDraw.e_shapeBit || B2DebugDraw.e_jointBit)
		window.physics.world.SetDebugDraw(debugDraw)

	start_game: () ->
		

	update: () ->
		# Update the physics engine each tick
		if window.viewModel.state() == 'PAUSE'
			# Don't step if we're paused
			if window.viewModel.debug()
				# If we're debugging
				window.physics.world.DrawDebugData()
			return
		window.physics.world.Step(1 / window.game.FPS, 10, 10)
		if window.viewModel.debug()
			window.physics.world.DrawDebugData()
		window.physics.world.ClearForces()

		window.physics.world.DestroyBody(entity.fixture.GetBody()) for entity in window.physics.entities_to_delete
		window.physics.entities_to_delete = []

	create_fixture_def: (entity) ->
		fixDef = new B2FixtureDef()

		if "density" of entity.physics
			fixDef.density = entity.physics.density					# Density
		if "friction" of entity.physics
			fixDef.friction = entity.physics.friction					# Friction
		if "restitution" of entity.physics
			fixDef.restitution = entity.physics.restitution				# Restitution

		if entity.physics.shape.type == "circle"
			fixDef.shape = new B2CircleShape(entity.physics.shape.size)		# Shape
		else if entity.physics.shape.type == "rectangle"
			fixDef.shape = new B2PolygonShape()

			if not ('size' of entity.physics.shape)
				entity.physics.shape.size =
					width: (entity.bitmaps[0].image.width * entity.bitmaps[0].scaleX) / (window.game.scale * 2)
					height: (entity.bitmaps[0].image.height * entity.bitmaps[0].scaleY) / (window.game.scale * 2)

			fixDef.shape.SetAsBox(entity.physics.shape.size.width, entity.physics.shape.size.height)
		else if entity.physics.shape.type == "polygon"
			fixDef.shape = new B2PolygonShape()
			vectors = []
			for vector in entity.physics.shape.vectors
				vectors.push(new B2Vec2(vector.x, vector.y))
			fixDef.shape.SetAsArray(vectors)
		return fixDef

	add_entity: (entity) ->
		bodyDef = new B2BodyDef()

		if entity.fixed
			bodyDef.type = B2Body.b2_staticBody
		else
			bodyDef.type = B2Body.b2_dynamicBody

		bodyDef.position.Set(entity.x, entity.y)

		if 'angle' of entity
			bodyDef.angle = entity.angle

		fixDef = window.physics.create_fixture_def(entity)

		body = window.physics.world.CreateBody(bodyDef)

		# body.SetSleepingAllowed(false)

		body.userData = entity.id
		entity.fixture = body.CreateFixture(fixDef) # Add to the world

	remove_entity: (entity, now) ->
		if now
			window.physics.world.DestroyBody(entity.fixture.GetBody())
		else
			window.physics.entities_to_delete.push(entity)