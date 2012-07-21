window.game.entity_types.box =
	name: "Box"
	image: "box.png"

	scale_adjustment: 1 # The box image is very big, a default box will be 0.2 * that size

	physics:
		density: 40
		friction: 2
		restitution: 0.2
		shape:
			type: "rectangle"