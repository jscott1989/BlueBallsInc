###global ko:false, SoundJS:false###
$menus = $('#menus')
$game = $('#game')
$pause_menu = $('#pause-menu')
$main_menu = $('#main-menu')

GameViewModel = ->
	self = this
	self.debug = ko.observable(true)
	self.level = ko.observable(1)
	self.tool = ko.observable("MOVE")
	self.last_tool = ko.observable("MOVE")
	self.state = ko.observable("BUILD")
	self.isPaused = ko.computed ->
		self.state() == 'PAUSE'
	self.isPlaying = ko.computed ->
		self.state() == 'PLAY'

	self.allowed_tools = ko.observableArray()
	
	self.replay_mode = ko.observable(false)
	self.replay_name = ko.observable(false)
	self.build_state = ko.observable(null) # This is the content of the

	self.intro = ko.observableArray()
	self.intro_pointer = ko.observable(0)

	self.intro_text = ko.computed ->
		if self.intro().length > self.intro_pointer()
			return self.intro()[self.intro_pointer()]
		return ''

	self.build_state_string = ko.computed ->
		JSON.stringify self.build_state()

	self.name = ko.observable() # The name attached to the current replay

	self.balls_complete = ko.observable(0)
	self.balls_needed = ko.observable(0)

	return

window.viewModel = new GameViewModel()
ko.applyBindings(window.viewModel)

load_level = (level_name) ->
	# Load a level from the server
	$.getJSON '/levels/' + level_name, (data) ->
		window.game.load_state data, true
		window.viewModel.state("INTRO")
		console.log window.viewModel.state()
		window.game.reset()

window.start_game = () ->
	window.game.start_game()
	load_level("level" + window.viewModel.level())
	return

window.level_complete = () ->
	if window.replay
		window.forward_to($('#replay-complete-menu'))
	else
		window.forward_to($('#level-complete-menu'))
	$menus.fadeIn()
	window.viewModel.state("COMPLETE")
	return false

$('.pause').click ->
	SoundJS.play("menu");
	window.forward_to($pause_menu)
	$menus.fadeIn()
	window.viewModel.last_state = window.viewModel.state()
	window.viewModel.state("PAUSE")
	return false

$('.resume').click ->
	SoundJS.play("start");
	$menus.fadeOut()
	window.viewModel.state(window.viewModel.last_state)
	return false

$('.start').click ->
	SoundJS.play("start");
	$('canvas').css('opacity', '100')
	if window.viewModel.state() == "BUILD"
		window.viewModel.state("PLAY")
	else
		if window.viewModel.replay_mode()
			window.viewModel.state("BUILD")
			window.game.load_state(window.replay.state)
			window.viewModel.state("PLAY")
		else
			window.viewModel.state("BUILD")

$('.confirm-exit-game').click ->
	SoundJS.play("menu");
	window.viewModel.state("BUILD")
	$game.fadeOut()

	window.backwards_to($main_menu)

$('.confirm-restart-level').click ->
	SoundJS.play("start");
	window.viewModel.state("BUILD")
	$menus.fadeOut()
	load_level("level" + window.viewModel.level())

	window.backwards_to($main_menu)

$('.watch-replay').click ->
	SoundJS.play("start");
	$('#replay-form').submit()
	window.backwards_to($('#level-complete-menu'))
	false

$('.watch-replay-again').click ->
	SoundJS.play("start");
	$menus.fadeOut()
	window.game.load_state(window.replay.state)
	window.viewModel.state("PLAY")

$('.next-level').click ->
	SoundJS.play("start");
	window.viewModel.level(window.viewModel.level() + 1)
	load_level("level" + window.viewModel.level())
	$menus.fadeOut()

$('#toolbox li').live 'click', () ->
	window.viewModel.last_tool(window.viewModel.tool())
	window.viewModel.tool($(this).attr('rel'))

$(window).resize ->
	window.game.refresh_canvas_position()

window.select_last_tool = () ->
	# Select the last selected tool (the current one is finished with)
	tmp_tool = window.viewModel.tool()
	window.viewModel.tool(window.viewModel.last_tool())
	window.viewModel.last_tool(tmp_tool)