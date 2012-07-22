window.game.entity_types.ball =
	name: "Ball"
	image: "ball.png"

	width_scale: 1
	height_scale: 1

	scale_adjustment: 0.5

	bodies: [{
		density: 40
		friction: 2
		restitution: 0.4
		shape:
			type: "circle"
			size: 1
	}]

	init: (entity) ->
		entity.tags.push("ball")