$ ->
	window.viewModel.replay_mode(true)
	window.viewModel.replay_name(window.replay.name)

	$('#menus').hide()
	$('#game').show()
	$('canvas').css('opacity', '0')
	window.game.load_state window.replay.state, true
	window.viewModel.state("REPLAY")