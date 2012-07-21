window.game.entity_types.magnet =
	name: "Magnet"
	image: "magnet.png"

	scale_adjustment: 1

	physics:
		density: 90
		friction: 2
		restitution: 0
		shape:
			type: "rectangle"

	init: (entity) ->
		entity.components.push('magnetized')