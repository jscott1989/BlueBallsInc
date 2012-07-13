###global Box2D:false, $:false, Stage:false, Ticker:false, Bitmap:false, Graphics:false, Shape:false###

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

	entities: []
	entityIDs: {} # Entities by ID
	walls: [] # The walls used before

	next_id: 1 # With random IDs

	stage: new Stage($('#gameCanvas')[0])

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

	create_entity: (entity) ->
		entity = $.extend({}, window.game.entity_types[entity.type], entity)
		if "init" of entity
			entity.init()

		if not 'id' of entity
			entity.id = 'entity_' + (window.game.next_id++)

		if 'image' of entity
			entity.bitmap = new Bitmap("/img/" + entity.image)
			entity.bitmap.regX = entity.bitmap.image.width * 0.5
			entity.bitmap.regY = entity.bitmap.image.height * 0.5

			window.game.stage.addChild(entity.bitmap)

		window.game.entities.push(entity)
		window.game.entityIDs[entity.id] = entity

		window.physics.add_entity(entity)

	create_wall: (wall) ->
		if wall == "bottom"
			window.game.create_entity({"type": "xwall","x": 11,"y": 19})
		else if wall == "top"
			window.game.create_entity({"type": "xwall","x": 11,"y": 0})
		else if wall == "left"
			window.game.create_entity({"type": "ywall","x": 0,"y": 9.5})
		else if wall == "right"
			window.game.create_entity({"type": "ywall","x": 22,"y": 9.5})

	load_state: (state, save_as_default) ->
		# Load the world to a given state

		if save_as_default
			window.game.default_state = state
			window.game.build_state = state

		window.game.create_entity(entity) for entity in state.entities if state.entities

		window.game.walls = state.walls
		window.game.create_wall(wall) for wall in window.game.walls

	get_state: () ->
		# Serialize the current game state
		state = {"entities": []}
		return state

	play: () ->
		# Start the simulation
		window.game.build_state = window.game.get_state()

	remove_entity: (entity) ->
		if "bitmap" of entity
			window.game.stage.removeChild(entity.bitmap)

		window.physics.remove_entity(entity)

	reset: () ->
		# Reset the simulation into the "build" state

		# TODO: Destroy entities, not bodies
		window.game.remove_entity(entity) for entity in window.game.entities

		window.game.entities = []

		window.game.load_state(window.game.build_state)

	reset_level: () ->
		# Reset to the beginning of the level, reverting any changes to the build
		window.game.remove_entity(entity) for entity in window.game.entities

		window.game.entities = []

		window.game.load_state(window.game.default_state)

	meters_to_pixels: (meters) ->
		meters * 30
	pixels_to_meters: (pixels) ->
		pixels / 30

	degrees_to_radians: (degrees) ->
		degrees * 0.0174532925199432957

	radians_to_degrees: (radians) ->
		radians * 57.295779513082320876

	update_position: (entity) ->
		if "bitmap" of entity
			# If we're drawing this
			position = entity.fixture.GetBody().GetPosition()
			entity.bitmap.x = window.game.meters_to_pixels(position.x)
			entity.bitmap.y = window.game.meters_to_pixels(position.y)
			entity.bitmap.rotation = window.game.radians_to_degrees(entity.fixture.GetBody().GetAngle())

	update_positions: () ->
		# Update the drawing positions to be in line with the physics
		window.game.update_position(entity) for entity in window.game.entities

	tick: () ->
		# Called each frame
		window.game.tools[window.viewModel.tool()].update()

		window.physics.update()

		window.game.update_positions()

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