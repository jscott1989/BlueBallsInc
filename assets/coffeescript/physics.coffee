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

window.physics =
	canvasPosition: {"x": 0, "y": 0}
	world: new B2World(new B2Vec2(0,10),  true)

	init: () ->
		# Initialise the physics engine

		# Set up DebugDraw
		debugDraw = new B2DebugDraw()
		debugDraw.SetSprite(window.game.debug_canvas.getContext("2d"))
		debugDraw.SetDrawScale(30)							# Scale
		debugDraw.SetFillAlpha(0.3)							# Transparency
		debugDraw.SetLineThickness(1.0)
		debugDraw.SetFlags(B2DebugDraw.e_shapeBit || B2DebugDraw.e_jointBit)
		window.physics.world.SetDebugDraw(debugDraw)

	start_game: () ->
		window.physics.refresh_canvas_position()

	refresh_canvas_position: () ->
		# This is needed as it can't be calculated until the canvas is visible
		window.physics.canvasPosition = window.game.$canvas.offset()

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

	create_fixture_def: (entity) ->
		fixDef = new B2FixtureDef()
		fixDef.density = entity.density					# Density
		fixDef.friction = entity.friction					# Friction
		fixDef.restitution = entity.restitution				# Restitution

		if entity.shape.type == "circle"
			fixDef.shape = new B2CircleShape(entity.shape.size)		# Shape
		else if entity.shape.type == "rectangle"
			fixDef.shape = new B2PolygonShape()
			fixDef.shape.SetAsBox(entity.shape.size.width, entity.shape.size.height)
		else if entity.shape.type == "polygon"
			fixDef.shape = new B2PolygonShape()
			vectors = []
			for vector in entity.shape.vectors
				vectors.push(new B2Vec2(vector.x, vector.y))
			fixDef.shape.SetAsArray(vectors)
		return fixDef

	create_entity: (entity, type) ->
		# Create an entity in the world
		bodyDef = new B2BodyDef()

		if type == "static"
			bodyDef.type = B2Body.b2_staticBody 	# Object type
		else
			bodyDef.type = B2Body.b2_dynamicBody 	# Object type
		bodyDef.position.Set(entity.x, entity.y)				# Position

		if 'angle' of entity
			bodyDef.angle = entity.angle

		fixDef = window.physics.create_fixture_def(entity)

		body = window.physics.world.CreateBody(bodyDef)
		created_entity = body.CreateFixture(fixDef) # Add to the world

		window.game.entities.push(created_entity)
		if 'id' of entity
			window.game.entityIDs[entity.id] = created_entity

	create_joint: (joint) ->
		if joint.type == 'revolute'
			j = new B2RevoluteJointDef()
		else if joint.type =='distance'
			j = new B2DistanceJointDef()
		else if joint.type =='weld'
			j = new B2WeldJointDef()
		j.bodyA = window.game.entityIDs[joint.bodyA].GetBody()
		j.bodyB = window.game.entityIDs[joint.bodyB].GetBody()
		if "localAnchorA" of joint
			j.localAnchorA.Set(joint.localAnchorA.x,joint.localAnchorA.y)
		if "motor" of joint
			if joint.motor.enabled
				j.enableMotor = true
				j.maxMotorTorque = 55
				j.motorSpeed=-10
		j = window.physics.world.CreateJoint(j)
		window.game.joints.push(j)