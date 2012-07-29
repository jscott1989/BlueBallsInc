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
count = 0

# We will contain all game logic in this object
window.game =
	tools:
		_: "" # This just ensures the tools object exists, tools will add themselves into this object

	bitmaps:
		glue: new Bitmap("/img/glue.png")
		magnet_beam: new Bitmap("/img/magnet-beam.png")

	FPS: 60
	scale: 30
	# Canvases
	$canvas: $('#gameCanvas')
	canvas: $('#gameCanvas')[0]
	$debug_canvas: $('#debugCanvas')
	debug_canvas: $('#debugCanvas')[0]
	canvas_position: {"x": 0, "y": 0}
	canvas_width: 700,
	canvas_height: 600

	entities: []
	entityIDs: {} # Entities by ID
	walls: [] # The walls used before

	next_id: 1 # With random IDs

	stage: new Stage($('#gameCanvas')[0])

	last_state: "BUILD"
	last_selected_tool: "MOVE" # The previously selected tool, used to inform when it's deselected

	next_intro: () ->
		if window.viewModel.intro().length == (window.viewModel.intro_pointer() + 1)
			window.viewModel.state('BUILD')
		else
			window.viewModel.intro_pointer(window.viewModel.intro_pointer() + 1)
			window.play_sound("intro");

	init: () ->
		# Initialise the game engine
		window.physics.init()
		window.game.stage.update()
		Ticker.setFPS(window.game.FPS)
		Ticker.addListener(this)

	start_game: () ->
		window.game.refresh_canvas_position()
		window.physics.start_game()

	refresh_canvas_position: () ->
		# This is needed as it can't be calculated until the canvas is visible
		window.game.canvas_position = window.game.$canvas.offset()

	state_changed: (state) ->
		# This is called when the stage changes (Between, BUILD, PLAY, and PAUSED)
		if state == 'BUILD'
			# Either first starting the level or returning from playing
			# Reset the level to the last built state
			if window.game.last_state != "PAUSE"
				# Not returning from pause
				window.game.reset()
		else if state == 'PLAY'
			# Starting playing
			if window.game.last_state != "PAUSE"
				# Not returning from pause
				window.game.play()

		window.game.last_state = state

	tool_changed: (new_tool) ->
		# This is called when the selected tool changes
		if 'deselect' of window.game.tools[window.game.last_selected_tool]
			window.game.tools[window.game.last_selected_tool].deselect()
		if 'select' of window.game.tools[new_tool]
			window.game.tools[new_tool].select()
		window.game.last_selected_tool = new_tool

	create_entity: (entity) ->
		entity = $.extend(true, {}, window.game.entity_base, window.game.entity_types[entity.type], entity)
		if "init" of entity and not ("initialised" of entity)
			entity.init(entity)
			entity.initialised = true

		if not entity.id
			entity.id = 'entity_' + (window.game.next_id++)

		if not ('bitmaps' of entity)
			entity.bitmaps = []

		if not ('touching' of entity)
			entity.touching = {}

		if 'image' of entity

			bitmap = new Bitmap("/img/" + entity.image)
			bitmap.regX = bitmap.image.width * 0.5
			bitmap.regY = bitmap.image.height * 0.5

			if "scale" of entity
				scale = 1
				if "scale" of entity
					scale = entity.scale
				scale_adjustment = 1
				if "scale_adjustment" of entity
					scale_adjustment = entity.scale_adjustment
				bitmap.scaleX = scale * scale_adjustment
				bitmap.scaleY = scale * scale_adjustment

			entity.bitmaps.push(bitmap)
			window.game.stage.addChild(bitmap)

		window.game.entities.push(entity)
		window.game.entityIDs[entity.id] = entity

		window.game.components[component].init(entity) for component in entity.components

		window.physics.add_entity(entity)

	create_wall: (wall) ->
		if wall == "bottom"
			window.game.create_entity({"type": "xwall","x": 11.6,"y": 20.1})
		else if wall == "top"
			window.game.create_entity({"type": "xwall","x": 11.5,"y": -0.1})
		else if wall == "left"
			window.game.create_entity({"type": "ywall","x": -0.1,"y": 10})
		else if wall == "right"
			window.game.create_entity({"type": "ywall","x": 23.4,"y": 10})

	load_state: (state, save_as_default) ->
		# Load the world to a given state
		window.game.clear_entities()

		if save_as_default
			window.game.default_state = state
			window.viewModel.build_state(state)

		window.game.create_entity(entity) for entity in state.entities if state.entities

		window.game.settings = state.settings
		# Set tools
		window.viewModel.allowed_tools.removeAll()
		window.viewModel.allowed_tools.push(tool) for tool in window.game.settings.tools

		window.viewModel.balls_needed(window.game.settings.balls_needed)

		window.viewModel.intro(state.intro)
		window.viewModel.intro_pointer(0)

		if not ("seed" of window.game.settings)
			window.game.settings.seed = Math.random()

		Math.seedrandom(window.game.settings.seed)

		window.game.walls = state.walls
		window.game.create_wall(wall) for wall in window.game.walls

	clean_entity: (entity) ->
		# Remove game specific items from an entity so it can be loaded in a clean state
		# This returns a copy
		entity = $.extend(true, {}, entity)


		# Position and angle
		if entity.fixtures.length > 0
			position = entity.fixtures[0].GetBody().GetPosition()
			entity.x = position.x
			entity.y = position.y
			entity.angle = entity.fixtures[0].GetBody().GetAngle()

		# TODO Initial forces? Maybe?

		delete entity.bitmaps
		delete entity.touching
		delete entity.fixtures
		delete entity.init

		for component in entity.components
			if 'clean' of window.game.components[component]
				window.game.components[component].clean(entity) 

		return entity

	get_state: () ->
		# Serialize the current game state
		state = {"walls": [], "settings": window.game.settings} # Walls are already included in entities

		state.entities = (window.game.clean_entity(entity) for entity in window.game.entities)

		return state

	play: () ->
		# Start the simulation
		window.viewModel.balls_complete(0)
		window.viewModel.build_state(window.game.get_state())
		# for entity in window.game.entities
		# 	window.game.components[component].play(entity) for component in entity.components


	remove_entity: (entity, now) ->
		if "bitmaps" of entity
			window.game.stage.removeChild(bitmap) for bitmap in entity.bitmaps

		window.physics.remove_entity(entity, now)

	clear_entities: () ->
		window.game.remove_entity(entity, true) for entity in window.game.entities
		window.game.entities = []
		window.game.entityIDs = []


	reset: () ->
		# Reset the simulation into the "build" state
		window.game.load_state(window.viewModel.build_state())
		# for entity in window.game.entities
		# 	window.game.components[component].reset(entity) for component in entity.components

	reset_level: () ->
		# Reset to the beginning of the level, reverting any changes to the build
		window.game.load_state(window.game.default_state)

	meters_to_pixels: (meters) ->
		meters * window.game.scale
	pixels_to_meters: (pixels) ->
		pixels / window.game.scale

	degrees_to_radians: (degrees) ->
		degrees * 0.0174532925199432957

	radians_to_degrees: (radians) ->
		radians * 57.295779513082320876

	update_position: (entity) ->
		if "bitmaps" of entity and entity.fixtures.length > 0
			# If we're drawing this
			position = entity.fixtures[0].GetBody().GetPosition()
			for bitmap in entity.bitmaps
				bitmap.x = window.game.meters_to_pixels(position.x)
				bitmap.y = window.game.meters_to_pixels(position.y)
				bitmap.rotation = window.game.radians_to_degrees(entity.fixtures[0].GetBody().GetAngle())

	update_positions: () ->
		# Update the drawing positions to be in line with the physics
		window.game.update_position(entity) for entity in window.game.entities

	tick: () ->
		# Called each frame
		window.game.tools[window.viewModel.tool()].update()

		for entity in window.game.entities
			window.game.components[component].update(entity) for component in entity.components

			if entity.top
				window.game.stage.addChild(entity.bitmaps[0])

		window.physics.update()

		window.game.update_positions()

		window.game.stage.update()

		if window.viewModel.state() == "PLAY" and window.viewModel.balls_complete() >= window.viewModel.balls_needed()
			# Level complete	
			window.level_complete()

	mouse_down: (e) ->
		if window.viewModel.state() == 'BUILD'
			# clientX = e.offsetX
			# clientY = e.offsetY
			clientX = window.game.mouseX * window.game.scale
			clientY = window.game.mouseY * window.game.scale
			$('#gameCanvas')[0].getContext("2d").fillRect(clientX, clientY, 1, 1);
			window.game.mouse_down = true
			if 'mouse_down' of window.game.tools[window.viewModel.tool()]
				window.game.tools[window.viewModel.tool()].mouse_down(e)
		else if window.viewModel.state() == 'INTRO'
			window.game.next_intro()

	mouse_up: (e) ->
		if window.viewModel.state() == 'BUILD'
			window.game.mouse_down = false
			if 'mouse_up' of window.game.tools[window.viewModel.tool()]
				window.game.tools[window.viewModel.tool()].mouse_up(e)

	mouse_move: (e) ->
		if window.viewModel.state() == 'BUILD'
			if e.offsetX
				window.game.mouseX = e.offsetX / window.game.scale
				window.game.mouseY = e.offsetY / window.game.scale
			else
				window.game.mouseX = e.pageX / window.game.scale
				window.game.mouseY = e.pageY / window.game.scale

			if 'mouse_move' of window.game.tools[window.viewModel.tool()]
				window.game.tools[window.viewModel.tool()].mouse_move(e)

	get_entity_at_mouse: () ->
		mousePVec = new B2Vec2(window.game.mouseX, window.game.mouseY)
		aabb = new B2AABB();
		aabb.lowerBound.Set(window.game.mouseX - 0.2, window.game.mouseY - 0.2)
		aabb.upperBound.Set(window.game.mouseX + 0.2, window.game.mouseY + 0.2)

		selected_body = null

		get_body_cb = (fixture) ->
			if fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), mousePVec)
				selected_body = fixture.GetBody()
				return false
			return true

		window.physics.world.QueryAABB(get_body_cb, aabb)
		if selected_body
			return window.game.entityIDs[selected_body.userData]

	get_entity_by_fixture: (fixture) ->
		return window.game.entityIDs[fixture.GetBody().userData]

	get_offset_to_mouse: (entity) ->
		body = entity.fixtures[0].GetBody()
		position = body.GetPosition()
		mouse_position = {"x": window.game.mouseX, "y": window.game.mouseY}

		rotated_position = window.game.rotate_point(mouse_position, position, 0-body.GetAngle())
		return {"x": position.x - rotated_position.x, "y": position.y - rotated_position.y}

	rotate_point: (point, origin, angle) ->
		s = Math.sin(angle)
		c = Math.cos(angle)

		point.x -= origin.x
		point.y -= origin.y

		xnew = point.x * c - point.y * s
		ynew = point.x * s + point.y * c

		point.x = xnew + origin.x
		point.y = ynew + origin.y

		return point


$('#narration').mousedown(window.game.mouse_down)
window.game.$debug_canvas.mousedown(window.game.mouse_down)
window.game.$debug_canvas.mouseup(window.game.mouse_up)
window.game.$debug_canvas.mousemove(window.game.mouse_move)
window.game.$canvas.mousedown(window.game.mouse_down)
window.game.$canvas.mouseup(window.game.mouse_up)
window.game.$canvas.mousemove(window.game.mouse_move)
window.game.init()

window.viewModel.state.subscribe window.game.state_changed
window.viewModel.tool.subscribe window.game.tool_changed