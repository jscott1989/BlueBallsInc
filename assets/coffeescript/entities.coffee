window.game.entity_types =
	box:
		name: "Box"
		image: "box.png"

		scale_adjustment: 0.2 # The box image is very big, a default box will be 0.2 * that size

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
			this.physics.shape.size.width = this.scale_adjustment * 6 *  this.scale
			this.physics.shape.size.height = this.scale_adjustment * 6 *  this.scale

	xwall:
		name: "Wall"
		fixed: true
		"physics":
			"shape":
		        "type": "rectangle"
		        "size":
		            "width": 11.5,
		            "height": 0.1

	ywall:
		name: "Wall"
		fixed: true
		"physics":
			"shape":
		        "type": "rectangle"
		        "size":
		            "width": 0.1,
		            "height": 10