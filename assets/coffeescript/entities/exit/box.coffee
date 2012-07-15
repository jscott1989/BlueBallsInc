# This is a box the ball will have to drop into to be "complete"
window.game.entity_types.exit_box =
	name: "Box"
	image: "exit_box.png"

	width_scale: 2
	height_scale: 2

	scale_adjustment: 0.5 # The box image is very big, a default box will be 0.2 * that size

	fixed: true

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
		this.physics.shape.size.width = this.scale_adjustment * this.width_scale *  this.scale
		this.physics.shape.size.height = this.scale_adjustment * this.height_scale *  this.scale