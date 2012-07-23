window.game.entity_types["conveyor-belt"] =
	name: "Conveyor Belt"
	image: "conveyor-belt.png"

	scale_adjustment: 1

	bodies: [
		{
			density: 40
			friction: 2
			restitution: 0.2
			shape:
				type: "rectangle"
		},
		{
			density: 40
			friction: 2
			restitution: 0.2
			shape:
				type: "circle"
				size: 1
			position:
				x: 4
				y: 0
		}
		{
			density: 40
			friction: 2
			restitution: 0.2
			shape:
				type: "circle"
				size: 1
			position:
				x: -4
				y: 0
		}
	]

	joints: [
		{
			
		}
	]

	init: (entity) ->
		entity.components.push('conveyor-belt')