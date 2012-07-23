window.game.entity_types['metal-ball'] =
	name: "Metal Ball"
	image: "metal-ball.png"

	bodies: [{
		density: 70
		friction: 2
		restitution: 0.2
		shape:
			type: "circle"
	}]
	init: (entity) ->
		entity.tags.push("magnetic")