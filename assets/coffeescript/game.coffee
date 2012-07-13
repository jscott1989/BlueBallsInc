###global Box2D:false, $:false, Stage:false, Ticker:false###

# TODO: Remove this once we have more elaborate entities
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


# We will contain all game logic in this object
window.game =
	tools:
		_: "" # This just ensures the tools object exists, tools will add themselves into this object

	FPS: 60
	# Canvases
	$canvas: $('#gameCanvas')
	canvas: $('#gameCanvas')[0]
	debug_canvas: $('#debugCanvas')[0]

	entities: [],
	entityIDs: {}, # Entities by ID

	stage: new Stage(window.game.canvas)

	init: () ->
		# Initialise the game engine
		window.physics.init()
		window.game.stage.update()
		Ticker.setFPS(window.game.FPS)
		Ticker.addListener(this)

	state_changed: (state) ->
		# This is called when the stage changes (Between, BUILD, PLAY, and PAUSED)
		if state == 'BUILD'
			# Either first starting the level or returning from playing
			# Reset the level to the last built state
			window.game.reset()
		else if state == 'PLAY'
			# Starting playing
			window.game.play()

	load_state: (state, save_as_default) ->
		# Load the world to a given state

		if save_as_default
			window.game.default_state = state
			window.game.build_state = state

		# TODO: Create entities with more properties
		window.physics.create_entity(entity, "dynamic") for entity in state.dynamic if state.dynamic
		window.physics.create_entity(entity, "static") for entity in state.static if state.static

	get_state: () ->
		# Serialize the current game state
		state = {"dynamic": [], "static": []}
		for entity in window.game.entities
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
				state.static.push(entity)
			else
				state.dynamic.push(entity)
		return state

	play: () ->
		# Start the simulation
		window.game.build_state = window.game.get_state()

	reset: () ->
		# Reset the simulation into the "build" state

		# TODO: Destroy entities, not bodies
		window.physics.world.DestroyBody(entity.GetBody()) for entity in window.game.entities

		window.game.entities = []

		window.game.load_state(window.game.build_state)


	reset_level: () ->
		# Reset to the beginning of the level, reverting any changes to the build
		window.physics.world.DestroyBody(entity.GetBody()) for entity in window.game.entities


		window.game.entities = []

		window.game.load_state(window.game.default_state)

	tick: () ->
		window.game.tools[window.viewModel.tool()].update()

		window.physics.update()
		window.game.stage.update()

	mouse_down: (e) ->
		window.game.tools[window.viewModel.tool()].mouse_down(e)

	mouse_up: (e) ->
		window.game.tools[window.viewModel.tool()].mouse_up(e)

	mouse_move: (e) ->
		window.game.tools[window.viewModel.tool()].mouse_move(e)

$(document).mousedown(window.game.mouse_down)
$(document).mouseup(window.game.mouse_up)
window.game.init()

window.viewModel.state.subscribe window.game.state_changed