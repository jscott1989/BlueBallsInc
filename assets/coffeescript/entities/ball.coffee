window.game.entity_types.ball =
	name: "Ball"
	image: "ball.png"

	width_scale: 1
	height_scale: 1

	scale_adjustment: 0.5 # The box image is very big, a default box will be 0.2 * that size

	physics:
		density: 40
		friction: 2
		restitution: 0.2
		shape:
			type: "circle"
			size: 1
	init: () ->
		this.physics.shape.size.width = this.scale_adjustment * this.width_scale *  this.scale
		this.physics.shape.size.height = this.scale_adjustment * this.height_scale *  this.scale