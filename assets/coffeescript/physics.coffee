###global Box2D:false, $:false###

B2MouseJointDef =  Box2D.Dynamics.Joints.b2MouseJointDef
B2Vec2 = Box2D.Common.Math.b2Vec2;
B2AABB = Box2D.Collision.b2AABB;
B2PointState = Box2D.Collision.b2PointState;
B2GetPointStates = Box2D.Collision.b2GetPointStates;
B2WorldManifold = Box2D.Collision.b2WorldManifold;
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

		sound_cutoff = 2.5
		max_velocity = 30

		x_velocity = Math.abs(bodyA.GetLinearVelocity().x)
		y_velocity = Math.abs(bodyA.GetLinearVelocity().y)

		if x_velocity > max_velocity
			x_velocity = max_velocity
		if y_velocity > max_velocity
			y_velocity = max_velocity

		if x_velocity > y_velocity
			biggest_velocity = x_velocity
		else
			biggest_velocity = y_velocity

		if biggest_velocity > sound_cutoff
			window.play_sound("collide", biggest_velocity / max_velocity)
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

	pre_solve: (contact, old_manifold) ->
		bodyA = contact.GetFixtureA().GetBody()
		bodyB = contact.GetFixtureB().GetBody()

		entityA = window.game.entityIDs[bodyA.userData]
		entityB = window.game.entityIDs[bodyB.userData]

		for component in entityA.components
			if "pre_solve" of window.game.components[component]
				window.game.components[component].pre_solve(entityA, entityB, contact)
		for component in entityB.components
			if "pre_solve" of window.game.components[component]
				window.game.components[component].pre_solve(entityB, entityA, contact)

	init: () ->
		# Initialise the physics engine

		window.physics.contact_listener = new B2ContactListener()

		window.physics.contact_listener.BeginContact = window.physics.begin_contact
		window.physics.contact_listener.EndContact = window.physics.end_contact
		window.physics.contact_listener.PreSolve = window.physics.pre_solve

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
		if window.viewModel.state() in ['PAUSE', 'INTRO']
			# Don't step if we're paused
			if window.viewModel.debug()
				# If we're debugging
				window.physics.world.DrawDebugData()
			return
		window.physics.world.Step(1 / window.game.FPS, 10, 10)
		if window.viewModel.debug()
			window.physics.world.DrawDebugData()
		window.physics.world.ClearForces()
		
		for entity in window.physics.entities_to_delete
			window.physics.world.DestroyBody(fixture.GetBody()) for fixture in entity.fixtures
		window.physics.entities_to_delete = []

	create_fixture_def: (entity, body) ->
		fixDef = new B2FixtureDef()

		if "density" of body
			fixDef.density = body.density					# Density
		if "friction" of body
			fixDef.friction = body.friction					# Friction
		if "restitution" of body
			fixDef.restitution = body.restitution				# Restitution

		if not ('position' of body)
				body.position = {
					x: 0
					y: 0
					angle: 0
				}

		if not ('x' of body.position)
			body.position.x = 0
		if not ('y' of body.position)
			body.position.y = 0
		if not ('angle' of body.position)
			body.position.angle = 0

		if body.shape.type == "circle"
			if not ('size' of body.shape)
				body.shape.size = (entity.bitmaps[0].image.width * entity.bitmaps[0].scaleX) / (window.game.scale * 2)
			fixDef.shape = new B2CircleShape(body.shape.size)		# Shape
			fixDef.shape.m_p.Set(body.position.x, body.position.y)

		else if body.shape.type == "rectangle"
			fixDef.shape = new B2PolygonShape()
			if not ('size' of body.shape)
				body.shape.size =
					width: (entity.bitmaps[0].image.width * entity.bitmaps[0].scaleX) / (window.game.scale * 2)
					height: (entity.bitmaps[0].image.height * entity.bitmaps[0].scaleY) / (window.game.scale * 2)
			
			fixDef.shape.SetAsOrientedBox(body.shape.size.width, body.shape.size.height, new B2Vec2(body.position.x, body.position.y), body.position.angle)
			
		else if body.shape.type == "polygon"
			fixDef.shape = new B2PolygonShape()
			vectors = []
			for vector in body.shape.vectors
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

		fixDefs = (window.physics.create_fixture_def(entity, body) for body in entity.bodies)

		body = window.physics.world.CreateBody(bodyDef)

		# body.SetSleepingAllowed(false)

		body.userData = entity.id
		entity.fixtures = (body.CreateFixture(fixDef) for fixDef in fixDefs)

	remove_entity: (entity, now) ->
		if now
			window.physics.world.DestroyBody(fixture.GetBody()) for fixture in entity.fixtures
		else
			window.physics.entities_to_delete.push(entity)