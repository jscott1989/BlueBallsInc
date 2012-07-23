window.game.entity_types.ball =
	name: "Ball"
	image: "ball.png"

	bodies: [{
		density: 40
		friction: 2
		restitution: 0.4
		shape:
			type: "circle"
	}]

	init: (entity) ->
		entity.tags.push("ball")