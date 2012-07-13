window.game.entity_types =
	box:
		name: "Box"
		image: "box.png"

		physics:
			density: 40
			friction: 2
			restitution: 0.2
			shape:
				type: "rectangle"
				size:
					width: 6
					height: 6
		init: () ->

	xwall:
		name: "Wall"
		fixed: true
		"physics":
			"shape":
		        "type": "rectangle"
		        "size":
		            "width": 11,
		            "height": 0.1

	ywall:
		name: "Wall"
		fixed: true
		"physics":
			"shape":
		        "type": "rectangle"
		        "size":
		            "width": 0.1,
		            "height": 9.5