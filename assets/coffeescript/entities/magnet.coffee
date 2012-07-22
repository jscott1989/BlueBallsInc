window.game.entity_types.magnet =
	name: "Magnet"
	image: "magnet.png"

	scale_adjustment: 1

	bodies: [{
		density: 90
		friction: 2
		restitution: 0
		shape:
			type: "polygon"
			vectors: [
				{"x": -0.9, "y": -1.1}
				{"x": 0, "y": -1.4}
				{"x": 1.4, "y": -1.1}
				{"x": 1.4, "y": -0.1}
				{"x": -0.1, "y": -0.5}
			]
	}, {
		density: 90
		friction: 2
		restitution: 0
		shape:
			type: "polygon"
			vectors: [
				{"x": -0.9, "y": -1.1}
				{"x": -0.1, "y": -0.5}
				{"x": -0.4, "y": 0}
				{"x": -1.4, "y": 0}
			]
	},{
		density: 90
		friction: 2
		restitution: 0
		shape:
			type: "polygon"
			vectors: [
				{"x": -1.4, "y": 0}
				{"x": -0.4, "y": 0}
				{"x": -0.4, "y": 1.4}
				{"x": -1, "y": 0.9}
			]
	},
	{
		density: 90
		friction: 2
		restitution: 0
		shape:
			type: "polygon"
			vectors: [
				{"x": -0.1, "y": 0.5}
				{"x": 1.4, "y": 0.1}
				{"x": 1.4, "y": 1.1}
				{"x": 0, "y": 1.4}
				{"x": -0.9, "y": 1.1}
			]
	}]
	# }, {
	# 	density: 90
	# 	friction: 2
	# 	restitution: 0
	# 	shape:
	# 		type: "polygon"
	# 		vectors: [
	# 			{"x": -1.1, "y": 1.1}
	# 			{"x": 0, "y": 1.4}
	# 			{"x": 1.4, "y": 1.1}
	# 			{"x": 1.4, "y": 0.1}
	# 			{"x": -0.1, "y": 0.5}
	# 		]
	# }]

	init: (entity) ->
		entity.components.push('magnetized')