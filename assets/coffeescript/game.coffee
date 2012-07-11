###global ko:false###
$menus = $('#menus')
$game = $('#game')
$pause_menu = $('#pause-menu')
$main_menu = $('#main-menu')

GameViewModel = ->
	self = this
	self.state = ko.observable("BUILD")
	self.isPaused = ko.computed ->
		self.state() == 'PAUSE'
	self.isPlaying = ko.computed ->
		self.state() == 'PLAY'

	return

window.viewModel = new GameViewModel()
ko.applyBindings(window.viewModel)

load_level = (level_name) ->
	# Load a level from the server
	$.getJSON '/levels/' + level_name, (data) ->
		window.game.load_state data, true
		window.viewModel.state("BUILD")
		window.game.reset()

window.start_game = () ->
	# Needed as we need to do this after the canvas is visible
	window.game.refresh_canvas_position()
	load_level("test")
	return

$('.pause').click ->
	window.forward_to($pause_menu)
	$menus.fadeIn()
	window.viewModel.last_state = window.viewModel.state()
	window.viewModel.state("PAUSE")
	return false

$('.resume').click ->
	$menus.fadeOut()
	window.viewModel.state(window.viewModel.last_state)
	return false

$('.start').click ->
	if window.viewModel.state() == "BUILD"
		window.viewModel.state("PLAY")
	else
		window.viewModel.state("BUILD")

$('.confirm-exit-game').click ->
	window.viewModel.state("BUILD")
	$game.fadeOut()

	window.backwards_to($main_menu)
