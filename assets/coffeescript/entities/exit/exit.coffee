# A simple, invisible exit point
window.game.entity_types.exit =
	name: "Box"
	fixed: true
	bodies: [{
		density: 40
		friction: 2
		restitution: 0.2
		shape:
			type: "rectangle"
			size:
				width: 0.1
				height: 0.1
	}]
	init: (entity) ->
		entity.components.push('exit')