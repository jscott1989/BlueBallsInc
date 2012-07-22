window.game.entity_types['metal-ball'] =
	name: "Metal Ball"
	image: "metal-ball.png"
	
	width_scale: 1
	height_scale: 1

	scale_adjustment: 0.5

	bodies: [{
		density: 70
		friction: 2
		restitution: 0.2
		shape:
			type: "circle"
			size: 1
	}]
	init: (entity) ->
		entity.tags.push("magnetic")