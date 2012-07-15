# Any ball which touches this from the "top" will be counted as completed

window.game.components.exit =
	init: (entity) ->

	update: (entity) ->

	begin_contact: (entity, other_entity) ->
		if "ball" in other_entity.tags
			window.game.remove_entity(other_entity)
			window.viewModel.balls_complete(window.viewModel.balls_complete() + 1)