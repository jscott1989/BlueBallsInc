# This is where the balls come from - this drops them into the game

window.game.entity_types.enter_dropper =
	name: "Ball Dropper"
	image: "enter_dropper.png"

	width_scale: 2
	height_scale: 2

	fixed: true

	scale_adjustment: 1 # The box image is very big, a default box will be 0.2 * that size

	scale: 0.5

	physics:
		density: 40
		friction: 2
		restitution: 0.2
		shape:
			type: "rectangle"
			size:
				width: 6
				height: 6
	init: (entity) ->
		entity.physics.shape.size.width = entity.scale_adjustment * entity.width_scale *  entity.scale
		entity.physics.shape.size.height = entity.scale_adjustment * entity.height_scale *  entity.scale

		entity.components.push('enter_dropper')