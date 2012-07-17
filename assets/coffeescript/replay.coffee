$ ->
	window.viewModel.replay_mode(true)
	window.viewModel.replay_name(window.replay.name)

	$('#menus').hide()
	$('#game').show()
	window.game.load_state(window.replay.state)
	window.viewModel.state("PLAY")
	window.viewModel.state("BUILD")
	window.game.load_state(window.replay.state)
	window.viewModel.state("PLAY")