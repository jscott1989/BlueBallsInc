window.game.entity_types["ledge"] =
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
				type: "rectangle"
				size:
					height: 0.5
					width: 5.2
			position:
				x: -0.1
				y: 0.2
		},
	]

	joints: [
		{
			
		}
	]