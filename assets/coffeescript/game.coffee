###global ko:false###
$menus = $('#menus')
$game = $('#game')
$pause_menu = $('#pause-menu')
$main_menu = $('#main-menu')

GameViewModel = ->
	self = this
	self.paused = ko.observable(false)
	self.level = ko.observable(1)
	self.money = ko.observable(500)

	return

viewModel = new GameViewModel()
ko.applyBindings(viewModel)

window.start_game = (level) ->
	window.clear_game()
	viewModel.paused(false)
	viewModel.level(level)
	viewModel.money(500)

	window.create_ball(2,1)
	return

$('.pause').click ->
	window.forward_to($pause_menu)

	$game.addClass('paused')
	$menus.fadeIn()
	viewModel.paused(true)
	return false

$('.resume').click ->
	$game.removeClass('paused')
	$menus.fadeOut()
	viewModel.paused(false)
	return false

$('.confirm-exit-game').click ->
	viewModel.paused(false)
	$game.fadeOut()

	window.backwards_to($main_menu)
