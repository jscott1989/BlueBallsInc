window.game.entity_types["conveyor-belt"] =
	name: "Conveyor Belt"
	image: "conveyor-belt.png"

	scale_adjustment: 1

	physics:
		density: 40
		friction: 2
		restitution: 0.2
		shape:
			type: "rectangle"

	init: (entity) ->
		entity.components.push('conveyor-belt')