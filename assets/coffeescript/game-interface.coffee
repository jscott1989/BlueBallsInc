###global ko:false###
$menus = $('#menus')
$game = $('#game')
$pause_menu = $('#pause-menu')
$main_menu = $('#main-menu')

GameViewModel = ->
	self = this
	self.debug = ko.observable(false)
	self.level = ko.observable("level1")
	self.tool = ko.observable("MOVE")
	self.last_tool = ko.observable("MOVE")
	self.state = ko.observable("BUILD")
	self.isPaused = ko.computed ->
		self.state() == 'PAUSE'
	self.isPlaying = ko.computed ->
		self.state() == 'PLAY'

	self.allowed_tools = ko.observableArray()

	self.balls_complete = ko.observable(0)
	self.balls_needed = ko.observable(0)

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
	window.game.start_game()
	load_level(window.viewModel.level())
	return

window.level_complete = () ->
	window.forward_to($('#level-complete-menu'))
	$menus.fadeIn()
	window.viewModel.state("COMPLETE")
	return false

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

$('.confirm-restart-level').click ->
	window.viewModel.state("BUILD")
	$menus.fadeOut()
	load_level(window.viewModel.level())

	window.backwards_to($main_menu)

$('#toolbox li').live 'click', () ->
	window.viewModel.last_tool(window.viewModel.tool())
	window.viewModel.tool($(this).attr('rel'))

window.select_last_tool = () ->
	# Select the last selected tool (the current one is finished with)
	tmp_tool = window.viewModel.tool()
	window.viewModel.tool(window.viewModel.last_tool())
	window.viewModel.last_tool(tmp_tool)