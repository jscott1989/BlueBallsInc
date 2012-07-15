# This is where the balls come from - this drops them into the game

window.game.entity_types.enter_dropper =
	name: "Ball Dropper"

	fixed: true

	physics:
		shape:
			type: "rectangle"
			size:
				width: 0.1
				height: 0.1
	init: (entity) ->
		entity.components.push('enter_dropper')