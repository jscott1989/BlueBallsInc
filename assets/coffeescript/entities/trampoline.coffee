window.game.entity_types.trampoline =
	name: "Trampoline"
	image: "trampoline.png"

	bodies: [{
		density: 40
		friction: 2
		restitution: 0.2
		shape:
			type: "polygon"
			vectors: [
				{"x": -2.2, "y": -1.7}
				{"x": -1.7, "y": -1.7}
				{"x": -1.7, "y": 1.6}
				{"x": -2.2, "y": 1.6}
			]
	},{
		density: 40
		friction: 2
		restitution: 0.2
		shape:
			type: "polygon"
			vectors: [
				{"x": 1.7, "y": -1.7}
				{"x": 2.2, "y": -1.7}
				{"x": 2.2, "y": 1.6}
				{"x": 1.7, "y": 1.6}
			]
	},{
		density: 40
		friction: 2
		restitution: 1
		shape:
			type: "polygon"
			vectors: [
				{"x": -2.1, "y": -1.7}
				{"x": 2.1, "y": -1.7}
				{"x": 2.1, "y": -1.2}
				{"x": -2.1, "y": -1.2}
			]
	}]