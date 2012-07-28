window.game.entity_types.ledge =
	name: "Ledge"
	image: "ledge.png"

	bodies: [
		{
			shape: 
				type: "rectangle"
				size:
					width: 0.1
					height: 0.1
		},
		{
			density: 40
			friction: 2
			restitution: 0.2
			shape:
				type: "polygon"
				vectors: [
					{"x": -4.8, "y": -0.3}
					{"x": 4.7, "y": -0.3}
					{"x": 5, "y": 0}
					{"x": 5, "y": 0.7}
					{"x": -5.2, "y": 0.7}
					{"x": -5.2, "y": 0}
				]
		},
	]

	joints: [
		{
			
		}
	]