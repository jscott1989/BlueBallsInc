$ ->
	window.viewModel.replay_mode(true)
	window.viewModel.replay_name(window.replay.name)

	$('#menus').hide()
	$('#game').show()
	window.game.load_state window.replay.state, true

	setTimeout () ->
		window.game.reset()
		window.viewModel.state("PLAY")
	, 100