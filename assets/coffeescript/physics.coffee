###global Box2D:false, $:false###

B2Vec2 = Box2D.Common.Math.b2Vec2;
B2BodyDef = Box2D.Dynamics.b2BodyDef;
B2Body = Box2D.Dynamics.b2Body;
B2FixtureDef = Box2D.Dynamics.b2FixtureDef;
B2Fixture = Box2D.Dynamics.b2Fixture;
B2World = Box2D.Dynamics.b2World;
B2MassData = Box2D.Collision.Shapes.b2MassData;
B2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape;
B2CircleShape = Box2D.Collision.Shapes.b2CircleShape;
B2DebugDraw = Box2D.Dynamics.b2DebugDraw;

canvas = $('#gameCanvas')[0]
debug_canvas = $('#debugCanvas')[0]

entities = []

window.game =
	_:
		state_changed: (state) ->
			if state == 'BUILD'
				window.game.reset()

		update: () ->
			if window.viewModel.state() in ['PAUSE', 'BUILD']
				window.game._.world.DrawDebugData()
				return
			window.game._.world.Step(1 / 60, 10, 10)
			window.game._.world.DrawDebugData()
			window.game._.world.ClearForces()
		entities: []

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


	create_dynamic_entity: (x, y) ->
		# Create an entity in the world
		bodyDef = new B2BodyDef()
		bodyDef.type = B2Body.b2_dynamicBody 	# Object type
		bodyDef.position.Set(x, y)				# Position

		fixDef = new B2FixtureDef()
		fixDef.density = 10.0					# Density
		fixDef.friction = 0.5					# Friction
		fixDef.restitution = 0.2				# Restitution

		fixDef.shape = new B2CircleShape(1)		# Shape

		entity = window.game._.world.CreateBody(bodyDef).CreateFixture(fixDef) # Add to the world

		window.game._.entities.push(entity)

	load_state: (state, save_as_default) ->
		# Load the world to a given state

		if save_as_default
			window.game.default_state = state

		window.game.state = state

	get_state: () ->
		# Serialize the current game state

	play: () ->
		# Start the simulation
		window.game.build_state = window.game.get_state()

	reset: () ->
		# Reset the simulation into the "build" state
		# window.game.load_state(window.game.build_state)
		window.game._.world.DestroyBody(entity.GetBody()) for entity in window.game._.entities

		window.game._.entities = []

		window.game.create_dynamic_entity(5,5)


	reset_hard: () ->
		# Reset to the beginning of the level, reverting any changes to the build

window.game.initialise()
window.setInterval(window.game._.update, 1000 / 60);

window.viewModel.state.subscribe window.game._.state_changed