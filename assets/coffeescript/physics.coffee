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

$canvas = $('#gameCanvas')
canvas = $canvas[0]
debug_canvas = $('#debugCanvas')[0]

entities = []

canvasPosition = $canvas.offset()

window.game =
	_:
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
			if window.game._.is_mouse_down && !window.game._.mouse_joint
				body = window.game.get_body_at_mouse()
				if body
					md = new B2MouseJointDef()
					md.bodyA = window.game._.world.GetGroundBody();
					md.bodyB = body;
					md.target.Set(window.game._.mouseX, window.game._.mouseY);
					md.collideConnected = true;
					md.maxForce = 300.0 * body.GetMass();
					window.game._.mouse_joint = window.game._.world.CreateJoint(md);
					body.SetAwake(true);

			if window.game._.mouse_joint
				if window.game._.is_mouse_down
					window.game._.mouse_joint.SetTarget(new B2Vec2(window.game._.mouseX, window.game._.mouseY))
				else
					window.game._.world.DestroyJoint(window.game._.mouse_joint)
					window.game._.mouse_joint = null

			if window.viewModel.state() == 'PAUSE'
				window.game._.world.DrawDebugData()
				return
			window.game._.world.Step(1 / 60, 10, 10)
			window.game._.world.DrawDebugData()
			window.game._.world.ClearForces()
		entities: []

	refresh_canvas_position: () ->
		canvasPosition = $canvas.offset()

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

		console.log entity
		if 'angle' of entity
			bodyDef.angle = entity.angle

		fixDef = window.game.create_fixture_def(entity)

		entity = window.game._.world.CreateBody(bodyDef).CreateFixture(fixDef) # Add to the world

		window.game._.entities.push(entity)

	create_static_entity: (entity) ->
		# Create a static entity, likely a floor or something
		bodyDef = new B2BodyDef()
		bodyDef.type = B2Body.b2_staticBody
		bodyDef.position.Set(entity.x, entity.y)

		if 'angle' of entity
			bodyDef.angle = entity.angle

		fixDef = window.game.create_fixture_def(entity)

		body = window.game._.world.CreateBody(bodyDef)
		body.CreateFixture(fixDef)

	load_state: (state, save_as_default) ->
		# Load the world to a given state

		if save_as_default
			window.game.default_state = state
			window.game.build_state = state

		window.game.create_dynamic_entity(entity) for entity in state.dynamic
		window.game.create_static_entity(entity) for entity in state.static

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
					"size": {"width": 1, "height": 1}
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

		window.game._.entities = []

		window.game.load_state(window.game.build_state)


	reset_hard: () ->
		# Reset to the beginning of the level, reverting any changes to the build

	mouse_down: (e) ->
		if e.clientX > canvasPosition.left && e.clientY > canvasPosition.top && e.clientX < canvasPosition.left + 660 && e.clientY < canvasPosition.top + 570
			window.game._.is_mouse_down = true;
			window.game.mouse_move(e)
			window.game._.selected_body = window.game.get_body_at_mouse()
			$(document).bind('mousemove', window.game.mouse_move)

	mouse_up: (e) ->
		window.game._.is_mouse_down = false

	mouse_move: (e) ->
		window.game._.mouseX = (e.clientX - canvasPosition.left) / 30
		window.game._.mouseY = (e.clientY - canvasPosition.top) / 30

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