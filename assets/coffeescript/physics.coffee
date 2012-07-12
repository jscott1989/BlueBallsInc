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

$canvas = $('#gameCanvas')
canvas = $canvas[0]
debug_canvas = $('#debugCanvas')[0]

window.game =
	tools:
		_:"_"
	_:
		canvasPosition: {"x": 0, "y": 0}
		is_mouse_down: false
		mouseX: false
		mouseY: false
		mouse_joint: false

		state_changed: (state) ->
			if state == 'BUILD'
				window.game.reset()
			else if state == 'PLAY'
				window.game.play()

		update: () ->
			window.game.tools[window.viewModel.tool()].update()

			if window.viewModel.state() == 'PAUSE'
				window.game._.world.DrawDebugData()
				return
			window.game._.world.Step(1 / 60, 10, 10)
			window.game._.world.DrawDebugData()
			window.game._.world.ClearForces()
		entities: [],
		entityIDs: {},
		joints: []

	refresh_canvas_position: () ->
		window.game._.canvasPosition = $canvas.offset()

	initialise: () ->
		# Initialise Box2D
		window.game._.world = new B2World(new B2Vec2(0,10),  true)

		# For now show debug info
		debugDraw = new B2DebugDraw()
		debugDraw.SetSprite(debug_canvas.getContext("2d"))
		debugDraw.SetDrawScale(30)							# Scale
		debugDraw.SetFillAlpha(0.3)							# Transparency
		debugDraw.SetLineThickness(1.0)
		debugDraw.SetFlags(B2DebugDraw.e_shapeBit || B2DebugDraw.e_jointBit)
		window.game._.world.SetDebugDraw(debugDraw)

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

	create_dynamic_entity: (entity) ->
		# Create an entity in the world
		bodyDef = new B2BodyDef()
		bodyDef.type = B2Body.b2_dynamicBody 	# Object type
		bodyDef.position.Set(entity.x, entity.y)				# Position

		if 'angle' of entity
			bodyDef.angle = entity.angle

		fixDef = window.game.create_fixture_def(entity)

		body = window.game._.world.CreateBody(bodyDef)
		created_entity = body.CreateFixture(fixDef) # Add to the world

		window.game._.entities.push(created_entity)
		if 'id' of entity
			window.game._.entityIDs[entity.id] = created_entity

	create_static_entity: (entity) ->
		# Create a static entity, likely a floor or something
		bodyDef = new B2BodyDef()
		bodyDef.type = B2Body.b2_staticBody
		bodyDef.position.Set(entity.x, entity.y)

		if 'angle' of entity
			bodyDef.angle = entity.angle

		fixDef = window.game.create_fixture_def(entity)

		body = window.game._.world.CreateBody(bodyDef)
		created_entity = body.CreateFixture(fixDef)

		window.game._.entities.push(created_entity)
		if 'id' of entity
			window.game._.entityIDs[entity.id] = created_entity

	create_joint: (joint) ->
		if joint.type == 'revolute'
			j = new B2RevoluteJointDef()
		else if joint.type =='distance'
			j = new B2DistanceJointDef()
		else if joint.type =='weld'
			j = new B2WeldJointDef()
		j.bodyA = window.game._.entityIDs[joint.bodyA].GetBody()
		j.bodyB = window.game._.entityIDs[joint.bodyB].GetBody()
		if "localAnchorA" of joint
			j.localAnchorA.Set(joint.localAnchorA.x,joint.localAnchorA.y)
		if "motor" of joint
			if joint.motor.enabled
				j.enableMotor = true
				j.maxMotorTorque = 55
				j.motorSpeed=-10
		j = window.game._.world.CreateJoint(j)
		window.game._.joints.push(j)
		console.log j

	load_state: (state, save_as_default) ->
		# Load the world to a given state

		if save_as_default
			window.game.default_state = state
			window.game.build_state = state

		window.game.create_dynamic_entity(entity) for entity in state.dynamic if state.dynamic
		window.game.create_static_entity(entity) for entity in state.static if state.static
		window.game.create_joint(joint) for joint in state.joints if state.joints

	get_state: () ->
		# Serialize the current game state
		state = {"dynamic": [], "static": []}
		for entity in window.game._.entities
			body = entity.GetBody()
			position = body.GetPosition()
			fixtures = body.GetFixtureList()
			shape = fixtures.GetShape()
			entity = {
				"x": position.x
				"y": position.y
				"density": fixtures.GetDensity()
				"friction": fixtures.GetFriction()
				"restitution": fixtures.GetRestitution()
				"angle": body.GetAngle()
				"shape": {
					"type": "rectangle"
				}
			}

			if shape.GetType() == 1 # Polygon
				entity.shape.type = 'polygon'
				entity.shape.vectors = []
				for vector of shape.m_vertices
					entity.shape.vectors.push({"x": shape.m_vertices[vector].x, "y": shape.m_vertices[vector].y})

			else if shape.GetType() == 0 # Circle
				entity.shape.type = 'circle'
				entity.shape.size = shape.m_radius

			if body.GetType() == B2Body.b2_staticBody
				state["static"].push(entity)
			else
				state["dynamic"].push(entity)
		return state

	play: () ->
		# Start the simulation
		window.game.build_state = window.game.get_state()

	reset: () ->
		# Reset the simulation into the "build" state
		# window.game.load_state(window.game.build_state)
		window.game._.world.DestroyBody(entity.GetBody()) for entity in window.game._.entities
		window.game._.world.DestroyJoint(joint) for joint in window.game._.joints

		window.game._.entities = []

		window.game.load_state(window.game.build_state)


	reset_hard: () ->
		# Reset to the beginning of the level, reverting any changes to the build
		window.game._.world.DestroyBody(entity.GetBody()) for entity in window.game._.entities
		window.game._.world.DestroyJoint(joint) for joint in window.game._.joints


		window.game._.entities = []

		window.game.load_state(window.game.default_state)

	mouse_down: (e) ->
		window.game.tools[window.viewModel.tool()].mouse_down(e)

	mouse_up: (e) ->
		window.game.tools[window.viewModel.tool()].mouse_up(e)

	mouse_move: (e) ->
		window.game.tools[window.viewModel.tool()].mouse_move(e)

	get_body_at_mouse: () ->
		window.game._.mousePVec = new B2Vec2(window.game._.mouseX, window.game._.mouseY)
		aabb = new B2AABB();
		aabb.lowerBound.Set(window.game._.mouseX - 0.1, window.game._.mouseY - 0.1)
		aabb.upperBound.Set(window.game._.mouseX + 0.1, window.game._.mouseY + 0.1)

		
		window.game._.selected_body = null
		window.game._.world.QueryAABB(window.game.get_body_cb, aabb)
		return window.game._.selected_body

	get_body_cb: (fixture) ->
		if fixture.GetBody().GetType() != B2Body.b2_staticBody
			if fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), window.game._.mousePVec)
				window.game._.selected_body = fixture.GetBody()
				position = window.game._.selected_body.GetPosition()
				window.game._.selected_body_offset = {"x": position.x - window.game._.mouseX, "y": position.y - window.game._.mouseY}
				return false
		return true


$(document).mousedown(window.game.mouse_down)
$(document).mouseup(window.game.mouse_up)
window.game.initialise()
window.setInterval(window.game._.update, 1000 / 60);

window.viewModel.state.subscribe window.game._.state_changed