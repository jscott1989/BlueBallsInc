window.game.entity_types['metal-ball'] =
	name: "Metal Ball"
	image: "metal-ball.png"
	
	width_scale: 1
	height_scale: 1

	scale_adjustment: 0.5

	physics:
		density: 70
		friction: 2
		restitution: 0.2
		shape:
			type: "circle"
			size: 1
	init: (entity) ->
		entity.tags.push("magnetic")
		this.physics.shape.size.width = this.scale_adjustment * this.width_scale *  this.scale
		this.physics.shape.size.height = this.scale_adjustment * this.height_scale *  this.scale